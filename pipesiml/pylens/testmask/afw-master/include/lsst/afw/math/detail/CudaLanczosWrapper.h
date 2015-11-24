// -*- LSST-C++ -*-

/*
 * LSST Data Management System
 * Copyright 2008 - 2012 LSST Corporation.
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
 * @file
 *
 * @brief GPU accelerared image warping
 *
 * @author Kresimir Cosic
 *
 * @ingroup afw
 */
#ifndef LSST_AFW_MATH_DETAIL_CUDALANCZOSWRAPPER_H
#define LSST_AFW_MATH_DETAIL_CUDALANCZOSWRAPPER_H

#include "lsst/afw/math/detail/SrcPosFunctor.h"
#include "lsst/afw/math/warpExposure.h"

namespace lsst {
namespace afw {
namespace math {
namespace detail {

namespace WarpImageGpuStatus
{
    enum ReturnCode {OK, NO_GPU, KERNEL_TOO_LARGE, INTERP_LEN_TOO_SMALL};
}

/**
 * \brief GPU accelerated image warping using Lanczos resampling
 *
 * \return a std::pair<int,WarpImageGpuStatus::ReturnValue> containing:
 *                1) the number of valid pixels in destImage (those that are not edge pixels).
 *                2) whether the warping was performed successfully, or error code
 *                        (if not OK, then the first value is not defined)
 *
 * This function requires a Lanczos warping kernel to perform the source value estimation.
 *
 * This function will not perform the warping if kernel size is too large.
 * (currently, when the order of the Lanczos kernel is >50)
 * If warping is not performed, the second elemnt of return value will not equal OK.
 * If forceProcessing is true:
 *       - this function will throw exceptions if a GPU device cannot be selected or used
 * If forceProcessing is false:
 *       - the warping will not be performed if the GPU code path is estimated to be slower
 *              than the CPU code path. That might happen if interpLength is too small (less than 3).
 *       - the warping will not be performed if a GPU device cannot be selected or used
 *
 * \pre maskWarpingKernel must not be greater in size than warpingKernel
 *
 * Also see lsst::afw::math::warpImage()
 *
 * \b Implementation:
 * Calculates values of the coordinate transform function at some points, which are spaced by interpLength intervals.
 * Calls CalculateInterpolationData() to calculate interpolation data from values of coordinate transformation fn.
 * Calls WarpImageGpuWrapper() to perform the wapring.
 *
 * \throw lsst::pex::exceptions::InvalidParameterException if interpLength < 1
 * \throw lsst::pex::exceptions::InvalidParameterException if maskWarpingKernel is neither Lanczos, bilinear
 *        nor nearest neighbor
 * \throw lsst::pex::exceptions::MemoryException when allocation of CPU memory fails
 * \throw lsst::afw::gpu::GpuMemoryException when allocation or transfer to/from GPU memory fails
 * \throw lsst::afw::gpu::GpuRuntimeErrorException when GPU code run fails
 *
 */
template<typename DestImageT, typename SrcImageT>
std::pair<int, WarpImageGpuStatus::ReturnCode> warpImageGPU(
    DestImageT &destImage,                  ///< remapped %image
    SrcImageT const &srcImage,              ///< source %image
    lsst::afw::math::LanczosWarpingKernel const &warpingKernel,   ///< warping kernel
    lsst::afw::math::SeparableKernel const &maskWarpingKernel,    ///< mask warping kernel (can be the same as warping kernel)
    SrcPosFunctor const &computeSrcPos,      ///< Functor to compute source position
    int const interpLength,                  ///< Distance over which WCS can be linearily interpolated
                                             ///< must be >0
    typename DestImageT::SinglePixel padValue, ///< value to use for undefined pixels
    const bool forceProcessing=true          ///< if true, this function will perform the warping even when
                                             ///< it is slower then the CPU code path
    );

}}}} // lsst::afw::math::detail

#endif // !defined(LSST_AFW_MATH_DETAIL_CUDALANCZOSWRAPPER_H)
