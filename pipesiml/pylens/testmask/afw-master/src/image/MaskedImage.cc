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
 * \file
 * \brief Implementation for MaskedImage
 */
#include <typeinfo>
#include <sys/stat.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
#include "boost/lambda/lambda.hpp"
#pragma clang diagnostic pop
#include "boost/regex.hpp"
#include "boost/filesystem/path.hpp"
#include "lsst/pex/logging/Trace.h"
#include "lsst/pex/exceptions.h"
#include "boost/algorithm/string/trim.hpp"

#include "lsst/afw/image/MaskedImage.h"
#include "lsst/afw/image/fits/fits_io.h"
#include "lsst/afw/fits.h"

namespace bl = boost::lambda;
namespace image = lsst::afw::image;

/** Constructors
 *
 * \brief Construct from a supplied dimensions. The Image, Mask, and Variance will be set to zero
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    unsigned int width, ///< number of columns
    unsigned int height, ///< number of rows
    MaskPlaneDict const& planeDict  //!< Make Mask conform to this mask layout (ignore if empty)
) :
    lsst::daf::base::Citizen(typeid(this)),
    _image(new Image(width, height)),
    _mask(new Mask(width, height, planeDict)),
    _variance(new Variance(width, height)) {
    *_image = 0;
    *_mask = 0x0;
    *_variance = 0;
}

/** Constructors
 *
 * \brief Construct from a supplied dimensions. The Image, Mask, and Variance will be set to zero
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    geom::Extent2I const & dimensions, //!< Number of columns, rows in image
    MaskPlaneDict const& planeDict  //!< Make Mask conform to this mask layout (ignore if empty)
) :
    lsst::daf::base::Citizen(typeid(this)),
    _image(new Image(dimensions)),
    _mask(new Mask(dimensions, planeDict)),
    _variance(new Variance(dimensions)) {
    *_image = 0;
    *_mask = 0x0;
    *_variance = 0;
}

/**
 * Create an MaskedImage of the specified size
 *
 * The Image, Mask, and Variance will be set to zero
 *
 * \note Many lsst::afw::image and lsst::afw::math objects define a \c dimensions member
 * which may be conveniently used to make objects of an appropriate size
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    geom::Box2I const & bbox, //!< dimensions of image: width x height
    MaskPlaneDict const& planeDict  //!< Make Mask conform to this mask layout (ignore if empty)
) :
    lsst::daf::base::Citizen(typeid(this)),
    _image(new Image(bbox)),
    _mask(new Mask(bbox, planeDict)),
    _variance(new Variance(bbox)) {
    *_image = 0;
    *_mask = 0x0;
    *_variance = 0;
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    std::string const & fileName, PTR(daf::base::PropertySet) metadata,
    geom::Box2I const & bbox, ImageOrigin origin, bool conformMasks, bool needAllHdus,
    PTR(daf::base::PropertySet) imageMetadata,
    PTR(daf::base::PropertySet) maskMetadata,
    PTR(daf::base::PropertySet) varianceMetadata
) : lsst::daf::base::Citizen(typeid(this)),
    _image(), _mask(), _variance() 
{
    fits::Fits fitsfile(fileName, "r", fits::Fits::AUTO_CLOSE | fits::Fits::AUTO_CHECK);
    *this = MaskedImage(fitsfile, metadata, bbox, origin, conformMasks, needAllHdus,
                        imageMetadata, maskMetadata, varianceMetadata);
 }

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    fits::MemFileManager & manager, PTR(daf::base::PropertySet) metadata,
    geom::Box2I const & bbox, ImageOrigin origin, bool conformMasks, bool needAllHdus,
    PTR(daf::base::PropertySet) imageMetadata,
    PTR(daf::base::PropertySet) maskMetadata,
    PTR(daf::base::PropertySet) varianceMetadata
) : lsst::daf::base::Citizen(typeid(this)),
    _image(), _mask(), _variance() 
{
    fits::Fits fitsfile(manager, "r", fits::Fits::AUTO_CLOSE | fits::Fits::AUTO_CHECK);
    *this = MaskedImage(fitsfile, metadata, bbox, origin, conformMasks, needAllHdus,
                        imageMetadata, maskMetadata, varianceMetadata);
}

namespace {

// Helper functions for MaskedImage FITS ctor.

void checkExtType(
    lsst::afw::fits::Fits & fitsfile,
    PTR(lsst::daf::base::PropertySet) metadata,
    std::string const & expected
) {
    try {
        std::string exttype = boost::algorithm::trim_right_copy(metadata->getAsString("EXTTYPE"));
        if (exttype != "" && exttype != expected) {
            throw LSST_EXCEPT(lsst::pex::exceptions::InvalidParameterException,
                              (boost::format("Reading %s (hdu %d) Expected EXTTYPE==\"%s\", saw \"%s\"") %
                               expected % fitsfile.getFileName() % fitsfile.getHdu() % exttype).str());
        }
        metadata->remove("EXTTYPE");
    } catch(lsst::pex::exceptions::NotFoundException) {}
}

void ensureMetadata(PTR(lsst::daf::base::PropertySet) & metadata) {
    if (!metadata) {
        metadata.reset(new lsst::daf::base::PropertyList());
    }
}

} // anonymous


template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    fits::Fits & fitsfile, PTR(daf::base::PropertySet) metadata,
    geom::Box2I const & bbox, ImageOrigin origin, bool conformMasks, bool needAllHdus,
    PTR(daf::base::PropertySet) imageMetadata,
    PTR(daf::base::PropertySet) maskMetadata,
    PTR(daf::base::PropertySet) varianceMetadata
) : lsst::daf::base::Citizen(typeid(this)),
    _image(), _mask(), _variance() 
{

    if (metadata) {
        // Read primary metadata - only if user asks for it.
        // If the primary HDU is not empty, this may be the same as imageMetadata.
        fitsfile.setHdu(1);
        fitsfile.readMetadata(*metadata);
    }

    fitsfile.setHdu(0); // this moves to the first non-empty HDU, which should always be the Image HDU.
    int hdu = fitsfile.getHdu();
    ensureMetadata(imageMetadata);
    _image.reset(new Image(fitsfile, imageMetadata, bbox, origin));
    checkExtType(fitsfile, imageMetadata, "IMAGE");

    try {
        fitsfile.setHdu(++hdu);
        ensureMetadata(maskMetadata);
        _mask.reset(new Mask(fitsfile, maskMetadata, bbox, origin, conformMasks));
        checkExtType(fitsfile, maskMetadata, "MASK");
    } catch(fits::FitsError &e) {
        if (needAllHdus) {
            LSST_EXCEPT_ADD(e, "Reading Mask");
            throw e;
        }
        _mask.reset(new Mask(_image->getBBox(PARENT)));
    }

    try {
        fitsfile.setHdu(++hdu);
        ensureMetadata(varianceMetadata);
        _variance.reset(new Variance(fitsfile, varianceMetadata, bbox, origin));
        checkExtType(fitsfile, varianceMetadata, "VARIANCE");
    } catch(fits::FitsError &e) {
        if (needAllHdus) {
            LSST_EXCEPT_ADD(e, "Reading Variance");
            throw e;
        }
        _variance.reset(new Variance(_image->getBBox(PARENT)));
    }
}

/**
 * \brief Construct from a supplied Image and optional Mask and Variance.
 * The Mask and Variance will be set to zero if omitted
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
        ImagePtr image,                 ///< %Image
        MaskPtr mask,                   ///< %Mask
        VariancePtr variance            ///< Variance %Mask
) :
    lsst::daf::base::Citizen(typeid(this)),
    _image(image),
    _mask(mask),
    _variance(variance) {
    conformSizes();
}

/**
 * \brief Copy constructor;  shallow, unless deep is true.
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    MaskedImage const& rhs, ///< %Image to copy
    bool deep               ///< Make deep copy?
) :
    lsst::daf::base::Citizen(typeid(this)),
    _image(rhs._image), _mask(rhs._mask), _variance(rhs._variance) {
    if (deep) {
        _image =    typename Image::Ptr(new Image(*rhs.getImage(), deep));
        _mask =     typename Mask::Ptr(new Mask(*rhs.getMask(), deep));
        _variance = typename Variance::Ptr(new Variance(*rhs.getVariance(), deep));
    }
    conformSizes();
}

/**
 * \brief Copy constructor of the pixels specified by bbox;  shallow, unless deep is true.
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::MaskedImage(
    MaskedImage const& rhs,     ///< MaskedImage to copy
    const geom::Box2I& bbox,    ///< Specify desired region
    ImageOrigin const origin,   ///< Specify the coordinate system of the bbox
    bool deep                   ///< If false, new ImageBase shares storage with rhs;
                                ///< if true make a new, standalone, MaskedImage
) :
    lsst::daf::base::Citizen(typeid(this)),
    _image(new Image(*rhs.getImage(), bbox, origin, deep)),
    _mask(rhs._mask ? new Mask(*rhs.getMask(), bbox, origin, deep) : static_cast<Mask *>(NULL)),
    _variance(rhs._variance ? new Variance(*rhs.getVariance(), bbox, origin, deep) : static_cast<Variance *>(NULL)) {
    conformSizes();
}

#if defined(DOXYGEN)
/**
 * \brief Make the lhs use the rhs's pixels
 *
 * If you are copying a scalar value, a simple <tt>lhs = scalar;</tt> is OK, but
 * this is probably not the function that you want to use with an %image. To copy pixel values
 * from the rhs use operator<<=()
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>& image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator=(image::MaskedImage const& rhs ///< Right hand side
                      ) {}
#endif

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::swap(MaskedImage &rhs) {
    using std::swap;                    // See Meyers, Effective C++, Item 25

    _image.swap(rhs._image);
    _mask.swap(rhs._mask);
    _variance.swap(rhs._variance);
}
// Use compiler generated version of:
//    MaskedImage<ImagePixelT, MaskPixelT> &operator=(const MaskedImage<ImagePixelT, MaskPixelT>& rhs);

/************************************************************************************************************/
// Operators
/**
 * Set the pixels in the MaskedImage to the rhs
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>&
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator=(MaskedImage::Pixel const& rhs) {
    *_image = rhs.image();
    *_mask = rhs.mask();
    *_variance = rhs.variance();

    return *this;
}

/**
 * Set the pixels in the MaskedImage to the rhs
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>&
image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator=(MaskedImage::SinglePixel const& rhs) {
    *_image = rhs.image();
    *_mask = rhs.mask();
    *_variance = rhs.variance();

    return *this;
}

/**
 * Copy the pixels from the rhs to the lhs
 *
 * \note operator=() is not equivalent to this command
 */
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator<<=(MaskedImage const& rhs) {
    *_image <<= *rhs.getImage();
    *_mask <<= *rhs.getMask();
    *_variance <<= *rhs.getVariance();
}

/// Add a MaskedImage rhs to a MaskedImage
///
/// The %image and variances are added; the masks are ORd together
///
/// \note The pixels in the two images are taken to be independent.  There is
/// a Pixel operation (plus) which models the covariance, but this is not (yet?)
/// available as full-MaskedImage operators
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator+=(MaskedImage const& rhs) {
    *_image += *rhs.getImage();
    *_mask  |= *rhs.getMask();
    *_variance += *rhs.getVariance();
}

/// Add a scaled MaskedImage c*rhs to a MaskedImage
///
/// The %image and variances are added; the masks are ORd together
///
/// \note The pixels in the two images are taken to be independent.  There is
/// a Pixel operation (plus) which models the covariance, but this is not (yet?)
/// available as full-MaskedImage operators
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::scaledPlus(double const c,
                                                                             MaskedImage const& rhs) {
    (*_image).scaledPlus(c, *rhs.getImage());
    *_mask  |= *rhs.getMask();
    (*_variance).scaledPlus(c*c, *rhs.getVariance());
}

/// Add a scalar rhs to a MaskedImage
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator+=(ImagePixelT const rhs) {
    *_image += rhs;
}

/// Subtract a MaskedImage rhs from a MaskedImage
///
/// The %images are subtracted; the masks are ORd together; and the variances are added
///
/// \note the pixels in the two images are taken to be independent
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator-=(MaskedImage const& rhs) {
    *_image -= *rhs.getImage();
    *_mask  |= *rhs.getMask();
    *_variance += *rhs.getVariance();
}

/// Subtract a scaled MaskedImage c*rhs from a MaskedImage
///
/// The %images are subtracted; the masks are ORd together; and the variances are added
///
/// \note the pixels in the two images are taken to be independent
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::scaledMinus(double const c,
                                                                              MaskedImage const& rhs) {
    (*_image).scaledMinus(c, *rhs.getImage());
    *_mask  |= *rhs.getMask();
    (*_variance).scaledPlus(c*c, *rhs.getVariance());
}

/// Subtract a scalar rhs from a MaskedImage
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator-=(ImagePixelT const rhs) {
    *_image -= rhs;
}

namespace {
    /// Functor to calculate the variance of the product of two independent variables
    template<typename ImagePixelT, typename VariancePixelT>
    struct productVariance {
        double operator()(ImagePixelT lhs, ImagePixelT rhs, VariancePixelT varLhs, VariancePixelT varRhs) {
            return lhs*lhs*varRhs + rhs*rhs*varLhs;
        }
    };

    /// Functor to calculate variance of the product of two independent variables, with the rhs scaled by c
    template<typename ImagePixelT, typename VariancePixelT>
    struct scaledProductVariance {
        double _c;
        scaledProductVariance(double const c) : _c(c) {}
        double operator()(ImagePixelT lhs, ImagePixelT rhs, VariancePixelT varLhs, VariancePixelT varRhs) {
            return _c*_c*(lhs*lhs*varRhs + rhs*rhs*varLhs);
        }
    };
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator*=(MaskedImage const& rhs) {
    // Must do variance before we modify the image values
    transform_pixels(_image->_getRawView(), // lhs
                     rhs._image->_getRawView(), // rhs,
                     _variance->_getRawView(),  // Var(lhs),
                     rhs._variance->_getRawView(), // Var(rhs)
                     _variance->_getRawView(), // result
                     productVariance<ImagePixelT, VariancePixelT>());

    *_image *= *rhs.getImage();
    *_mask  |= *rhs.getMask();
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::scaledMultiplies(double const c,
                                                                                   MaskedImage const& rhs) {
    // Must do variance before we modify the image values
    transform_pixels(_image->_getRawView(), // lhs
                     rhs._image->_getRawView(), // rhs,
                     _variance->_getRawView(),  // Var(lhs),
                     rhs._variance->_getRawView(), // Var(rhs)
                     _variance->_getRawView(), // result
                     scaledProductVariance<ImagePixelT, VariancePixelT>(c));

    (*_image).scaledMultiplies(c, *rhs.getImage());
    *_mask  |= *rhs.getMask();
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator*=(ImagePixelT const rhs) {
    *_image *= rhs;
    *_variance *= rhs*rhs;
}


namespace {
    /// Functor to calculate the variance of the ratio of two independent variables
    template<typename ImagePixelT, typename VariancePixelT>
    struct quotientVariance {
        double operator()(ImagePixelT lhs, ImagePixelT rhs, VariancePixelT varLhs, VariancePixelT varRhs) {
            ImagePixelT const rhs2 = rhs*rhs;
            return (lhs*lhs*varRhs + rhs2*varLhs)/(rhs2*rhs2);
        }
    };
    /// Functor to calculate the variance of the ratio of two independent variables, the second scaled by c
    template<typename ImagePixelT, typename VariancePixelT>
    struct scaledQuotientVariance {
        double _c;
        scaledQuotientVariance(double c) : _c(c) {}
        double operator()(ImagePixelT lhs, ImagePixelT rhs, VariancePixelT varLhs, VariancePixelT varRhs) {
            ImagePixelT const rhs2 = rhs*rhs;
            return (lhs*lhs*varRhs + rhs2*varLhs)/(_c*_c*rhs2*rhs2);
        }
    };
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator/=(MaskedImage const& rhs) {
    // Must do variance before we modify the image values
    transform_pixels(_image->_getRawView(), // lhs
                     rhs._image->_getRawView(), // rhs,
                     _variance->_getRawView(),  // Var(lhs),
                     rhs._variance->_getRawView(), // Var(rhs)
                     _variance->_getRawView(), // result
                     quotientVariance<ImagePixelT, VariancePixelT>());

    *_image /= *rhs.getImage();
    *_mask  |= *rhs.getMask();
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::scaledDivides(double const c,
                                                                                MaskedImage const& rhs) {
    // Must do variance before we modify the image values
    transform_pixels(_image->_getRawView(), // lhs
                     rhs._image->_getRawView(), // rhs,
                     _variance->_getRawView(),  // Var(lhs),
                     rhs._variance->_getRawView(), // Var(rhs)
                     _variance->_getRawView(), // result
                     scaledQuotientVariance<ImagePixelT, VariancePixelT>(c));

    (*_image).scaledDivides(c, *rhs.getImage());
    *_mask  |= *rhs._mask;
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::operator/=(ImagePixelT const rhs) {
    *_image /= rhs;
    *_variance /= rhs*rhs;
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::writeFits(
    std::string const& fileName,
    CONST_PTR(daf::base::PropertySet) metadata,
    CONST_PTR(daf::base::PropertySet) imageMetadata,
    CONST_PTR(daf::base::PropertySet) maskMetadata,
    CONST_PTR(daf::base::PropertySet) varianceMetadata
) const {
    fits::Fits fitsfile(fileName, "w", fits::Fits::AUTO_CLOSE | fits::Fits::AUTO_CHECK);
    writeFits(fitsfile, metadata, imageMetadata, maskMetadata, varianceMetadata);
}

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::writeFits(
    fits::MemFileManager & manager,
    CONST_PTR(daf::base::PropertySet) metadata,
    CONST_PTR(daf::base::PropertySet) imageMetadata,
    CONST_PTR(daf::base::PropertySet) maskMetadata,
    CONST_PTR(daf::base::PropertySet) varianceMetadata
) const {
    fits::Fits fitsfile(manager, "w", fits::Fits::AUTO_CLOSE | fits::Fits::AUTO_CHECK);
    writeFits(fitsfile, metadata, imageMetadata, maskMetadata, varianceMetadata);
}

namespace {

void processPlaneMetadata(
    CONST_PTR(lsst::daf::base::PropertySet) metadata,
    PTR(lsst::daf::base::PropertySet) & hdr,
    char const * exttype
) {
    if (metadata) {
        hdr = metadata->deepCopy();
    } else {
        hdr.reset(new lsst::daf::base::PropertyList());
    }
    hdr->set("INHERIT", true);
    hdr->set("EXTTYPE", exttype);
}

} // anonymous

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::writeFits(
    fits::Fits & fitsfile,
    CONST_PTR(daf::base::PropertySet) metadata,
    CONST_PTR(daf::base::PropertySet) imageMetadata,
    CONST_PTR(daf::base::PropertySet) maskMetadata,
    CONST_PTR(daf::base::PropertySet) varianceMetadata
) const {

    PTR(daf::base::PropertySet) hdr;
    if (metadata) {
        hdr = metadata->deepCopy();
    } else {
        hdr.reset(new daf::base::PropertyList());
    }

    if (fitsfile.countHdus() != 0) {
        throw LSST_EXCEPT(
            pex::exceptions::LogicErrorException,
            "MaskedImage::writeFits can only write to an empty file"
        );
    }
    if (fitsfile.getHdu() <= 1) {
        // Don't ever write images to primary; instead we make an empty primary.
        fitsfile.createEmpty();
    } else {
        fitsfile.setHdu(1);
    }
    fitsfile.writeMetadata(*hdr);

    processPlaneMetadata(imageMetadata, hdr, "IMAGE");
    _image->writeFits(fitsfile, hdr);

    processPlaneMetadata(maskMetadata, hdr, "MASK");
    _mask->writeFits(fitsfile, hdr);

    processPlaneMetadata(varianceMetadata, hdr, "VARIANCE");
    _variance->writeFits(fitsfile, hdr);
}

/************************************************************************************************************/
// private function conformSizes() ensures that the Mask and Variance have the same dimensions
// as Image.  If Mask and/or Variance have non-zero dimensions that conflict with the size of Image,
// a lsst::pex::exceptions::LengthError is thrown.

template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
void image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::conformSizes() {

    if (!_mask || _mask->getWidth() == 0 || _mask->getHeight() == 0) {
        _mask = MaskPtr(new Mask(_image->getBBox(PARENT)));
        *_mask = 0;
    } else {
        if (_mask->getDimensions() != _image->getDimensions()) {
            throw LSST_EXCEPT(
                lsst::pex::exceptions::LengthErrorException,
                (boost::format("Dimension mismatch: Image %dx%d v. Mask %dx%d") %
                    _image->getWidth() % _image->getHeight() % 
                    _mask->getWidth() % _mask->getHeight()
                ).str()
            );
        }
    }

    if (!_variance || _variance->getWidth() == 0 || _variance->getHeight() == 0) {
        _variance = VariancePtr(new Variance(_image->getBBox(PARENT)));
        *_variance = 0;
    } else {
        if (_variance->getDimensions() != _image->getDimensions()) {
            throw LSST_EXCEPT(
                lsst::pex::exceptions::LengthErrorException,
                (boost::format("Dimension mismatch: Image %dx%d v. Variance %dx%d") %
                    _image->getWidth() % _image->getHeight() % 
                    _variance->getWidth() % _variance->getHeight()
                ).str()
            );
        }
    }
}

/************************************************************************************************************/
//
// Iterators and locators
//
/// Return an \c iterator to the start of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::begin() const {
#if 0                                   // this doesn't compile; why?
    return iterator(_image->begin(), _mask->begin(), _variance->begin());
#else
    typename Image::iterator imageBegin = _image->begin();
    typename Mask::iterator maskBegin = _mask->begin();
    typename Variance::iterator varianceBegin = _variance->begin();

    return iterator(imageBegin, maskBegin, varianceBegin);
#endif
}

/// Return an \c iterator to the end of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::end() const {
    typename Image::iterator imageEnd = getImage()->end();
    typename Mask::iterator maskEnd = getMask()->end();
    typename Variance::iterator varianceEnd = getVariance()->end();

    return iterator(imageEnd, maskEnd, varianceEnd);
}

/// Return an \c iterator at the point <tt>(x, y)</tt>
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::at(int const x, int const y) const {
    typename Image::iterator imageEnd = getImage()->at(x, y);
    typename Mask::iterator maskEnd = getMask()->at(x, y);
    typename Variance::iterator varianceEnd = getVariance()->at(x, y);

    return iterator(imageEnd, maskEnd, varianceEnd);
}

/// Return a \c reverse_iterator to the start of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::reverse_iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::rbegin() const {
    typename Image::reverse_iterator imageBegin = _image->rbegin();
    typename Mask::reverse_iterator maskBegin = _mask->rbegin();
    typename Variance::reverse_iterator varianceBegin = _variance->rbegin();

    return reverse_iterator(imageBegin, maskBegin, varianceBegin);
}

/// Return a \c reverse_iterator to the end of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::reverse_iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::rend() const {
    typename Image::reverse_iterator imageEnd = getImage()->rend();
    typename Mask::reverse_iterator maskEnd = getMask()->rend();
    typename Variance::reverse_iterator varianceEnd = getVariance()->rend();

    return reverse_iterator(imageEnd, maskEnd, varianceEnd);
}

/// Return an \c x_iterator to the start of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::x_iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::row_begin(int y) const {
    typename Image::x_iterator imageBegin = _image->row_begin(y);
    typename Mask::x_iterator maskBegin = _mask->row_begin(y);
    typename Variance::x_iterator varianceBegin = _variance->row_begin(y);

    return x_iterator(imageBegin, maskBegin, varianceBegin);
}

/// Return an \c x_iterator to the end of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::x_iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::row_end(int y) const {
    typename Image::x_iterator imageEnd = getImage()->row_end(y);
    typename Mask::x_iterator maskEnd = getMask()->row_end(y);
    typename Variance::x_iterator varianceEnd = getVariance()->row_end(y);

    return x_iterator(imageEnd, maskEnd, varianceEnd);
}

/************************************************************************************************************/

/// Return an \c y_iterator to the start of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::y_iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::col_begin(int x) const {
    typename Image::y_iterator imageBegin = _image->col_begin(x);
    typename Mask::y_iterator maskBegin = _mask->col_begin(x);
    typename Variance::y_iterator varianceBegin = _variance->col_begin(x);

    return y_iterator(imageBegin, maskBegin, varianceBegin);
}

/// Return an \c y_iterator to the end of the %image
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::y_iterator image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::col_end(int x) const {
    typename Image::y_iterator imageEnd = getImage()->col_end(x);
    typename Mask::y_iterator maskEnd = getMask()->col_end(x);
    typename Variance::y_iterator varianceEnd = getVariance()->col_end(x);

    return y_iterator(imageEnd, maskEnd, varianceEnd);
}

/************************************************************************************************************/
/// Fast iterators to contiguous images
///
/// Return a fast \c iterator to the start of the %image, which must be contiguous
/// Note that the order in which pixels are visited is undefined.
///
/// \exception lsst::pex::exceptions::Runtime
/// Argument \a contiguous is false, or the pixels are not in fact contiguous
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::fast_iterator
    image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::begin(
        bool contiguous         ///< Pixels are contiguous (must be true)
                                                                      ) const {
    typename Image::fast_iterator imageBegin = _image->begin(contiguous);
    typename Mask::fast_iterator maskBegin = _mask->begin(contiguous);
    typename Variance::fast_iterator varianceBegin = _variance->begin(contiguous);

    return fast_iterator(imageBegin, maskBegin, varianceBegin);
}

/// Return a fast \c iterator to the end of the %image, which must be contiguous
/// Note that the order in which pixels are visited is undefined.
///
/// \exception lsst::pex::exceptions::Runtime
/// Argument \a contiguous is false, or the pixels are not in fact contiguous
template<typename ImagePixelT, typename MaskPixelT, typename VariancePixelT>
typename image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::fast_iterator
    image::MaskedImage<ImagePixelT, MaskPixelT, VariancePixelT>::end(
        bool contiguous                 ///< Pixels are contiguous (must be true)
                                                                    ) const {
    typename Image::fast_iterator imageEnd = getImage()->end(contiguous);
    typename Mask::fast_iterator maskEnd = getMask()->end(contiguous);
    typename Variance::fast_iterator varianceEnd = getVariance()->end(contiguous);

    return fast_iterator(imageEnd, maskEnd, varianceEnd);
}

/************************************************************************************************************/
//
// Explicit instantiations
//
template class image::MaskedImage<boost::uint16_t>;
template class image::MaskedImage<int>;
template class image::MaskedImage<float>;
template class image::MaskedImage<double>;
template class image::MaskedImage<boost::uint64_t>;

