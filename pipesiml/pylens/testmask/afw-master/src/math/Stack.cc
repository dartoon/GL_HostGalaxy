// -*- lsst-c++ -*-

/* 
 * LSST Data Management System
 * Copyright 2008, 2009, 2010 LSST Corporation.
 * 
 * This product includes software developed by the
 * LSST Project (http://www.lsst.org/).
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the LSST License Statement and 
 * the GNU General Public License along with this program.  If not, 
 * see <http://www.lsstcorp.org/LegalNotices/>.
 */
 
/**
 * @file Stack.cc
 * @brief Provide functions to stack images
 * @ingroup stack
 * @author Steve Bickerton
 *
 */
#include <vector>
#include <cassert>
#include "boost/shared_ptr.hpp"

#include "lsst/base.h"
#include "lsst/utils/ieee.h"
#include "lsst/pex/exceptions.h"
#include "lsst/afw/math/Stack.h"
#include "lsst/afw/math/MaskedVector.h"

namespace afwGeom = lsst::afw::geom;
namespace afwImage = lsst::afw::image;
namespace afwMath  = lsst::afw::math;
namespace pexExcept = lsst::pex::exceptions;

namespace {
    typedef std::vector<afwMath::WeightPixel> WeightVector; // vector of weights (yes, really)
/*
 * A bit counter (to make sure that only one type of statistics has been requested)
 */
int bitcount(unsigned int x)
{
    int b;
    for (b = 0; x != 0; x >>= 1) {
        if (x & 01) {
            b++;
        }
    }
    return b;
}

/*
 * Check that only one type of statistics has been requested.
 */
void checkOnlyOneFlag(unsigned int flags) {
    if (bitcount(flags & ~afwMath::ERRORS) != 1) {
        throw LSST_EXCEPT(pexExcept::InvalidParameterException,
                          "Requested more than one type of statistic to make the image stack.");
                          
    }
    
}

    /*
     * Check that we have objects, and the right number of weights (or none)
     */
    template<typename ObjectVectorT, typename WeightVectorT>
    void checkObjectsAndWeights(ObjectVectorT const& objects,
                                WeightVectorT const& wvector
                               )
    {
        if (objects.size() == 0) {
            throw LSST_EXCEPT(pexExcept::LengthErrorException, "Please specify at least one object to stack");
        }

        if (!wvector.empty() && wvector.size() != objects.size() ) {
            throw LSST_EXCEPT(pexExcept::InvalidParameterException,
                              str(boost::format("Weight vector has different length "
                                                "from number of objects to be stacked: %d v. %d")
                                  % wvector.size() % objects.size()));
        }
    }

    template<typename ImageT>
    void checkImageSizes(ImageT const& out, std::vector<PTR(ImageT)> const& images)
    {
        afwGeom::Extent2I const& dim = out.getDimensions();
        for (unsigned int i = 0; i < images.size(); ++i) {
            if (images[i]->getDimensions() != dim) {
                throw LSST_EXCEPT(pexExcept::InvalidParameterException,
                                  (boost::format("Bad dimensions for image %d: %dx%d vs %dx%d") %
                                   i % images[i]->getDimensions().getX() % images[i]->getDimensions().getY() %
                                   dim.getX() % dim.getY()).str());
            }
        }
    }

/****************************************************************************
 *
 * stack MaskedImages
 *
 ****************************************************************************/
/*
 * A function to handle MaskedImage stacking
 *
 * A boolean template variable has been used to allow the compiler to generate the different instantiations
 *   to handle cases when we are, or are not, weighting
 *
 * Additionally, we may or may not want to weight based on the variance -- another template boolean
 */
template<typename PixelT, bool isWeighted, bool useVariance>
void computeMaskedImageStack(
    afwImage::MaskedImage<PixelT> & imgStack,
    std::vector<typename afwImage::MaskedImage<PixelT>::Ptr > const &images,
    afwMath::Property flags,
    afwMath::StatisticsControl const& sctrl,
    WeightVector const &wvector=WeightVector()
    )
{
    // get a list of row_begin iterators
    typedef typename afwImage::MaskedImage<PixelT>::x_iterator x_iterator;
    std::vector<x_iterator> rows;
    rows.reserve(images.size());

    afwMath::MaskedVector<PixelT> pixelSet(images.size()); // a pixel from x,y for each image
    WeightVector weights;                                  // weights; non-const version
    //
    afwMath::StatisticsControl sctrlTmp(sctrl);

    if (useVariance) {                  // weight using the variance image
        assert(isWeighted);
        assert(wvector.empty());
        
        weights.resize(images.size());

        sctrlTmp.setWeighted(true);
    } else if (isWeighted) {
        weights.assign(wvector.begin(), wvector.end());

        sctrlTmp.setWeighted(true);
    }
    assert (weights.empty() || weights.size() == images.size());

    // loop over x,y ... the loop over the stack to fill pixelSet
    // - get the stats on pixelSet and put the value in the output image at x,y
    for (int y = 0; y != imgStack.getHeight(); ++y) {

        for (unsigned int i = 0; i < images.size(); ++i) {
            x_iterator ptr = images[i]->row_begin(y);
            if (y == 0) {
                rows.push_back(ptr);
            } else {
                rows[i] = ptr;
            }
        }

        for (x_iterator ptr = imgStack.row_begin(y), end = imgStack.row_end(y); ptr != end; ++ptr) {
            typename afwMath::MaskedVector<PixelT>::iterator psPtr = pixelSet.begin();
            WeightVector::iterator wtPtr = weights.begin();
            for (unsigned int i = 0; i < images.size(); ++rows[i], ++i, ++psPtr, ++wtPtr) {
                *psPtr = *rows[i];
                if (useVariance) {      // we're weighting using the variance
                    *wtPtr = 1.0/rows[i].variance();
                }
            }

            afwMath::Property const eflags = static_cast<afwMath::Property>(flags |
                                                                            afwMath::NPOINT | afwMath::ERRORS);
            afwMath::Statistics stat = isWeighted ?
                afwMath::makeStatistics(pixelSet, weights, eflags, sctrlTmp) :
                afwMath::makeStatistics(pixelSet,          eflags, sctrlTmp);
            
            PixelT variance = ::pow(stat.getError(flags), 2);
            afwImage::MaskPixel msk(stat.getOrMask());
            int const npoint = stat.getValue(afwMath::NPOINT);
            if (npoint == 0) {
                msk = sctrlTmp.getNoGoodPixelsMask();
            } else if (npoint == 1) {
                /*
                 * you should be using sctrl.setCalcErrorFromInputVariance(true) if you want to avoid
                 * getting a variance of NaN when you only have one input
                 */
            }

            *ptr = typename afwImage::MaskedImage<PixelT>::Pixel(stat.getValue(flags), msk, variance);
        }
    }
}
    
} // end anonymous namespace


/*
 * A function to compute some statistics of a stack of Masked Images
 *
 * If none of the input images are valid for some pixel,
 * the afwMath::StatisticsControl::getNoGoodPixelsMask() bit(s) are set.
 *
 * All the work is done in the function computeMaskedImageStack.
 */
template<typename PixelT>
typename afwImage::MaskedImage<PixelT>::Ptr afwMath::statisticsStack(
        std::vector<typename afwImage::MaskedImage<PixelT>::Ptr > &images,
        afwMath::Property flags,                                          
        afwMath::StatisticsControl const& sctrl,                          
        WeightVector const &wvector                                       
                                                              )
{
    if (images.size() == 0) {
        throw LSST_EXCEPT(pexExcept::LengthErrorException, "Please specify at least one image to stack");
    }
    typename afwImage::MaskedImage<PixelT>::Ptr out(
        new afwImage::MaskedImage<PixelT>(images[0]->getDimensions()));
    statisticsStack(*out, images, flags, sctrl, wvector);
    return out;
}
template<typename PixelT>
void afwMath::statisticsStack(
    afwImage::MaskedImage<PixelT>& out,
        std::vector<typename afwImage::MaskedImage<PixelT>::Ptr > &images,
        afwMath::Property flags,                                          
        afwMath::StatisticsControl const& sctrl,                          
        WeightVector const &wvector                                       
                                                              )
{
    checkObjectsAndWeights(images, wvector);
    checkOnlyOneFlag(flags);
    checkImageSizes(out, images);

    if (sctrl.getWeighted()) {
        if (wvector.empty()) {
            return computeMaskedImageStack<PixelT, true, true>(out, images, flags, sctrl); // use variance
        } else {
            return computeMaskedImageStack<PixelT, true, false>(out, images, flags, sctrl,
                                                                wvector); // use wvector
        }
    } else {
        return computeMaskedImageStack<PixelT, false, false>(out, images, flags, sctrl);
    }
}


namespace {
/****************************************************************************
 *
 * stack Images
 *
 * All the work is done in the function comuteImageStack.
 * A boolean template variable has been used to allow the compiler to generate the different instantiations
 *   to handle cases when we are, or are not, weighting
 *
 ****************************************************************************/
/*
 * A function to compute some statistics of a stack of regular images
 *
 * A boolean template variable has been used to allow the compiler to generate the different instantiations
 *   to handle cases when we are, or are not, weighting
 */
template<typename PixelT, bool isWeighted>
void computeImageStack(
    afwImage::Image<PixelT> & imgStack,
        std::vector<typename afwImage::Image<PixelT>::Ptr > &images,  
        afwMath::Property flags,               
        afwMath::StatisticsControl const& sctrl,
        WeightVector const &weights=WeightVector()
    )
{
    afwMath::MaskedVector<PixelT> pixelSet(images.size()); // a pixel from x,y for each image
    afwMath::StatisticsControl sctrlTmp(sctrl);

    // set the mask to be an infinite iterator
    afwMath::MaskImposter<afwImage::MaskPixel> msk;

    if (!weights.empty()) {
        sctrlTmp.setWeighted(true);
    }
        
    // get the desired statistic
    for (int y = 0; y != imgStack.getHeight(); ++y) {
        for (int x = 0; x != imgStack.getWidth(); ++x) {
            for (unsigned int i = 0; i != images.size(); ++i) {
                (*pixelSet.getImage())(i, 0) = (*images[i])(x, y);
            }
            
            if (isWeighted) {
                imgStack(x, y) = afwMath::makeStatistics(pixelSet, weights, flags, sctrlTmp).getValue();
            } else {
                imgStack(x, y) = afwMath::makeStatistics(pixelSet, weights, flags, sctrlTmp).getValue();
            }
        }
    }
}

} // end anonymous namespace



template<typename PixelT>
typename afwImage::Image<PixelT>::Ptr afwMath::statisticsStack(
        std::vector<typename afwImage::Image<PixelT>::Ptr > &images,  
        afwMath::Property flags,               
        afwMath::StatisticsControl const& sctrl,
        WeightVector const &wvector
                                                        )
{
    if (images.size() == 0) {
        throw LSST_EXCEPT(pexExcept::LengthErrorException, "Please specify at least one image to stack");
    }
    typename afwImage::Image<PixelT>::Ptr out(new afwImage::Image<PixelT>(images[0]->getDimensions()));
    statisticsStack(*out, images, flags, sctrl, wvector);
    return out;
}

template<typename PixelT>
void afwMath::statisticsStack(
    afwImage::Image<PixelT> & out,
    std::vector<typename afwImage::Image<PixelT>::Ptr > &images,  
    afwMath::Property flags,               
    afwMath::StatisticsControl const& sctrl,
    WeightVector const &wvector
    )
{
    checkObjectsAndWeights(images, wvector);
    checkOnlyOneFlag(flags);
    checkImageSizes(out, images);

    if (wvector.empty()) {
        return computeImageStack<PixelT, false>(out, images, flags, sctrl);
    } else {
        return computeImageStack<PixelT, true>(out, images, flags, sctrl, wvector);
    }
}

/****************************************************************************
 *
 * stack VECTORS
 *
 ****************************************************************************/

namespace {

/**********************************************************************************/
/*
 * A function to compute some statistics of a stack of vectors
 *
 * A boolean template variable has been used to allow the compiler to generate the different instantiations
 *   to handle cases when we are, or are not, weighting
 */
template<typename PixelT, bool isWeighted>
typename boost::shared_ptr<std::vector<PixelT> > computeVectorStack(
        std::vector<boost::shared_ptr<std::vector<PixelT> > > &vectors,  
        afwMath::Property flags,               
        afwMath::StatisticsControl const& sctrl,
        WeightVector const &wvector=WeightVector()
                                                                      )
{
    // create the image to be returned
    typedef std::vector<PixelT> Vect;
    boost::shared_ptr<Vect> vecStack(new Vect(vectors[0]->size(), 0.0));

    afwMath::MaskedVector<PixelT> pixelSet(vectors.size()); // values from a given pixel of each image

    afwMath::StatisticsControl sctrlTmp(sctrl);
    // set the mask to be an infinite iterator
    afwMath::MaskImposter<afwImage::MaskPixel> msk;
    
    if (!wvector.empty()) {
        sctrlTmp.setWeighted(true);
    }
    
    // collect elements from the stack into the MaskedVector to do stats
    for (unsigned int x = 0; x < vectors[0]->size(); ++x) {
        typename afwMath::MaskedVector<PixelT>::iterator psPtr = pixelSet.begin();
        for (unsigned int i = 0; i < vectors.size(); ++i, ++psPtr) {
            psPtr.value() = (*vectors[i])[x];
        }

        if (isWeighted) {
            (*vecStack)[x] = afwMath::makeStatistics(pixelSet, wvector, flags, sctrlTmp).getValue(flags);
        } else {
            (*vecStack)[x] = afwMath::makeStatistics(pixelSet, flags, sctrlTmp).getValue(flags);
        }
    }

    return vecStack;
}

} // end anonymous namespace



template<typename PixelT>
boost::shared_ptr<std::vector<PixelT> > afwMath::statisticsStack(
        std::vector<boost::shared_ptr<std::vector<PixelT> > > &vectors,  
        afwMath::Property flags,               
        afwMath::StatisticsControl const& sctrl,
        WeightVector const &wvector
                                                                      )
{
    checkObjectsAndWeights(vectors, wvector);
    checkOnlyOneFlag(flags);

    if (wvector.empty()) {
        return computeVectorStack<PixelT, false>(vectors, flags, sctrl);
    } else {
        return computeVectorStack<PixelT, true>(vectors, flags, sctrl, wvector);
    }
}

/**************************************************************************
 *
 * XY row column stacking
 *
 **************************************************************************/

template<typename PixelT>
typename afwImage::MaskedImage<PixelT>::Ptr afwMath::statisticsStack(
        afwImage::Image<PixelT> const &image,  
        afwMath::Property flags,               
        char dimension,
        afwMath::StatisticsControl const& sctrl
                                                                 ) {


    int x0 = image.getX0();
    int y0 = image.getY0();
    typedef afwImage::MaskedImage<PixelT> MImage;
    typename MImage::Ptr imgOut;

    // do each row or column, one at a time
    // - create a subimage with a bounding box, and get the stats and assign the value to the output image
    if (dimension == 'x') {
        imgOut = typename MImage::Ptr(
            new MImage(geom::Extent2I(1, image.getHeight()))
        );
        int y = y0;
        typename MImage::y_iterator oEnd = imgOut->col_end(0);
        for (typename MImage::y_iterator oPtr = imgOut->col_begin(0); oPtr != oEnd; ++oPtr, ++y) {
            geom::Box2I bbox = afwGeom::Box2I(
                geom::Point2I(x0, y), 
                geom::Extent2I(image.getWidth(), 1)
            );
            afwImage::Image<PixelT> subImage(image, bbox, afwImage::PARENT);
            Statistics stat = makeStatistics(subImage, flags | afwMath::ERRORS, sctrl);
            *oPtr = typename afwImage::MaskedImage<PixelT>::Pixel(
                stat.getValue(), 0x0, 
                stat.getError()*stat.getError()
            );
        }

    } else if (dimension == 'y') {
        imgOut = typename MImage::Ptr(new MImage(geom::Extent2I(image.getWidth(), 1)));
        int x = x0;
        typename MImage::x_iterator oEnd = imgOut->row_end(0);
        for (typename MImage::x_iterator oPtr = imgOut->row_begin(0); oPtr != oEnd; ++oPtr, ++x) {
            geom::Box2I bbox = geom::Box2I(
                geom::Point2I(x, y0), geom::Extent2I(1, image.getHeight())
            );
            afwImage::Image<PixelT> subImage(image, bbox, afwImage::PARENT);
            afwMath::Statistics stat = makeStatistics(subImage, flags | afwMath::ERRORS, sctrl);
            *oPtr = typename afwImage::MaskedImage<PixelT>::Pixel(stat.getValue(), 0x0, 
                                                                  stat.getError()*stat.getError());
        }
    } else {
        throw LSST_EXCEPT(pexExcept::InvalidParameterException,
                          "Can only run statisticsStack in x or y for single image.");
    }

    return imgOut;
}



template<typename PixelT>
typename afwImage::MaskedImage<PixelT>::Ptr afwMath::statisticsStack(
        afwImage::MaskedImage<PixelT> const &image,  
        afwMath::Property flags,               
        char dimension,
        afwMath::StatisticsControl const& sctrl
                                                                 )
{
    int const x0 = image.getX0();
    int const y0 = image.getY0();
    typedef afwImage::MaskedImage<PixelT> MImage;
    typename MImage::Ptr imgOut;

    // do each row or column, one at a time
    // - create a subimage with a bounding box, and get the stats and assign the value to the output image
    if (dimension == 'x') {
        imgOut = typename MImage::Ptr(new MImage(geom::Extent2I(1, image.getHeight())));
        int y = 0;
        typename MImage::y_iterator oEnd = imgOut->col_end(0);
        for (typename MImage::y_iterator oPtr = imgOut->col_begin(0); oPtr != oEnd; ++oPtr, ++y) {
            afwGeom::Box2I bbox = afwGeom::Box2I(afwGeom::Point2I(x0, y), geom::Extent2I(image.getWidth(), 1));
            afwImage::MaskedImage<PixelT> subImage(image, bbox, afwImage::PARENT);
            afwMath::Statistics stat = makeStatistics(subImage, flags | afwMath::ERRORS, sctrl);
            *oPtr = typename afwImage::MaskedImage<PixelT>::Pixel(stat.getValue(), 0x0, 
                                                                  stat.getError()*stat.getError());
        }

    } else if (dimension == 'y') {
        imgOut = typename MImage::Ptr(new MImage(geom::Extent2I(image.getWidth(), 1)));
        int x = 0;
        typename MImage::x_iterator oEnd = imgOut->row_end(0);
        for (typename MImage::x_iterator oPtr = imgOut->row_begin(0); oPtr != oEnd; ++oPtr, ++x) {
            afwGeom::Box2I bbox = afwGeom::Box2I(afwGeom::Point2I(x, y0), geom::Extent2I(1, image.getHeight()));
            afwImage::MaskedImage<PixelT> subImage(image, bbox, afwImage::PARENT);
            afwMath::Statistics stat = makeStatistics(subImage, flags | afwMath::ERRORS, sctrl);
            *oPtr = typename afwImage::MaskedImage<PixelT>::Pixel(stat.getValue(), 0x0, 
                                                                  stat.getError()*stat.getError());
        }
    } else {
        throw LSST_EXCEPT(pexExcept::InvalidParameterException,
                          "Can only run statisticsStack in x or y for single image.");
    }

    return imgOut;
}

/************************************************************************************************************/
/*
 * Explicit Instantiations
 *
 */
/// \cond
#define INSTANTIATE_STACKS(TYPE) \
    template afwImage::Image<TYPE>::Ptr afwMath::statisticsStack<TYPE>( \
            std::vector<afwImage::Image<TYPE>::Ptr > &images, \
            afwMath::Property flags, \
            afwMath::StatisticsControl const& sctrl,    \
            WeightVector const &wvector);                          \
    template void afwMath::statisticsStack<TYPE>( \
            afwImage::Image<TYPE> &out, \
            std::vector<afwImage::Image<TYPE>::Ptr > &images, \
            afwMath::Property flags, \
            afwMath::StatisticsControl const& sctrl,    \
            WeightVector const &wvector);                          \
    template afwImage::MaskedImage<TYPE>::Ptr afwMath::statisticsStack<TYPE>( \
            std::vector<afwImage::MaskedImage<TYPE>::Ptr > &images, \
            afwMath::Property flags, \
            afwMath::StatisticsControl const& sctrl,    \
            WeightVector const &wvector);                          \
    template void afwMath::statisticsStack<TYPE>( \
            afwImage::MaskedImage<TYPE> &out, \
            std::vector<afwImage::MaskedImage<TYPE>::Ptr > &images, \
            afwMath::Property flags, \
            afwMath::StatisticsControl const& sctrl,    \
            WeightVector const &wvector);                          \
    template boost::shared_ptr<std::vector<TYPE> > afwMath::statisticsStack<TYPE>( \
            std::vector<boost::shared_ptr<std::vector<TYPE> > > &vectors, \
            afwMath::Property flags, \
            afwMath::StatisticsControl const& sctrl,    \
            WeightVector const &wvector);                               \
    template afwImage::MaskedImage<TYPE>::Ptr afwMath::statisticsStack( \
            afwImage::Image<TYPE> const &image, \
            afwMath::Property flags,                    \
            char dimension,                                     \
            afwMath::StatisticsControl const& sctrl); \
    template afwImage::MaskedImage<TYPE>::Ptr afwMath::statisticsStack( \
            afwImage::MaskedImage<TYPE> const &image, \
            afwMath::Property flags,                    \
            char dimension,                                     \
            afwMath::StatisticsControl const& sctrl);

INSTANTIATE_STACKS(double)
INSTANTIATE_STACKS(float)
/// \endcond
