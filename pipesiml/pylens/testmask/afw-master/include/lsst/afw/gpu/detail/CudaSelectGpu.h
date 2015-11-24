// -*- LSST-C++ -*-

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
 * @file
 *
 * @brief Functions to help managing setup for GPU kernels
 *
 * Functions in this file are used to query GPU device,
 * and to simplify GPu device selection
 *
 * @author Kresimir Cosic
 *
 * @ingroup afw
 */

namespace lsst {
namespace afw {
namespace gpu {
namespace detail {


/// selects a cuda device
void SetCudaDevice(int devId);

/// reserves cuda device
void CudaReserveDevice();

/// frees resources and releases current cuda device
void CudaThreadExit();

// gets the preferred cuda device id from a CUDA_DEVICE environment variable
// if the CUDA_DEVICE environment variable is not set, returns -2 (preferred device not specified)
int GetPreferredCudaDevice();

// returns true when preffered device has been selected
// returns false when preffered device is not specified
// throws exception when unable to select the preffered device
bool SelectPreferredCudaDevice();

// If cuda device is already selected and reserved, does nothing
// otherwise, attempts to select the best available GPU
// throws exception when automatic selection fails
void AutoSelectCudaDevice();

// verifies basic parameters of selected cuda device
// throws exceptions when the selected GPU is not 'good enough'
// Intention was mainly to guard against integrated GPUs or very old GPUs
void VerifyCudaDevice();

// Tries to select a cuda device, but only the first time this function is called.
// All subsequent calls will return the previous result.
// To select again, set reselect to true.
// Attempts to use the preferred device.
// If a preferred device is not specified, it attempts to auto-select.
// Finally, it verifies the selected cuda device.
// returns true if gpu device was sucesssfully selected at this call or at a previous call
// returns false if gpu device selection failed at this call or at a previous call
// Throws exceptions if device selection fails due to any reason (only on a first call or on reselect)
// When noExceptions is set to true, no exceptions will be thrown.
bool TryToSelectCudaDevice(bool noExceptions, bool reselect=false);


}}}} //namespace lsst::afw::math::detail::gpu ends

