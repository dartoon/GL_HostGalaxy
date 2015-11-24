#!/usr/bin/env python

# 
# LSST Data Management System
# Copyright 2008, 2009, 2010 LSST Corporation.
# 
# This product includes software developed by the
# LSST Project (http://www.lsst.org/).
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the LSST License Statement and 
# the GNU General Public License along with this program.  If not, 
# see <http://www.lsstcorp.org/LegalNotices/>.
#

"""
Test lsst.afw.image.Exposure

Author: Nicole M. Silvestri, University of Washington
Contact: nms@astro.washington.edu
Created on: Mon Sep 10, 2007
"""

import os
import os.path
import unittest

import numpy

import eups
import lsst.daf.base as dafBase
import lsst.afw.detection as afwDetection
import lsst.afw.image as afwImage
import lsst.afw.math as afwMath
import lsst.afw.geom as afwGeom
import lsst.afw.coord as afwCoord
import lsst.afw.table as afwTable
import lsst.afw.cameraGeom as cameraGeom
import lsst.utils.tests as utilsTests
import lsst.pex.exceptions as pexExcept
import lsst.pex.logging as pexLog
import lsst.pex.policy as pexPolicy
import lsst.afw.fits
from testTableArchivesLib import DummyPsf

try:
    type(VERBOSITY)
except:
    VERBOSITY = 0                       # increase to see trace

pexLog.Debug("lsst.afw.image", VERBOSITY)

try:
    dataDir = os.path.join(eups.productDir("afwdata"), "data")
except Exception:
    raise RuntimeError("Must set up afwdata to run these tests")

InputMaskedImageName = "871034p_1_MI.fits"
InputMaskedImageNameSmall = "small_MI.fits"
InputImageNameSmall = "small"
OutputMaskedImageName = "871034p_1_MInew.fits"

currDir = os.path.abspath(os.path.dirname(__file__))
inFilePath = os.path.join(dataDir, InputMaskedImageName)
inFilePathSmall = os.path.join(dataDir, InputMaskedImageNameSmall)
inFilePathSmallImage = os.path.join(dataDir, InputImageNameSmall)
outFile = OutputMaskedImageName

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

class ExposureTestCase(unittest.TestCase):
    """
    A test case for the Exposure Class
    """

    def setUp(self):
        maskedImage = afwImage.MaskedImageF(inFilePathSmall)
        maskedImageMD = afwImage.readMetadata(inFilePathSmall)

        self.smallExposure = afwImage.ExposureF(inFilePathSmall)
        self.width =  maskedImage.getWidth()
        self.height = maskedImage.getHeight()
        self.wcs = afwImage.makeWcs(maskedImageMD)
        self.psf = DummyPsf(2.0)

        self.exposureBlank = afwImage.ExposureF()
        self.exposureMiOnly = afwImage.makeExposure(maskedImage)
        self.exposureMiWcs = afwImage.makeExposure(maskedImage, self.wcs)
        self.exposureCrWcs = afwImage.ExposureF(100, 100, self.wcs)         # n.b. the (100, 100, ...) form
        self.exposureCrOnly = afwImage.ExposureF(afwGeom.ExtentI(100, 100)) # test with ExtentI(100, 100) too

        afwImage.Filter.reset()
        afwImage.FilterProperty.reset()

        filterPolicy = pexPolicy.Policy()
        filterPolicy.add("lambdaEff", 470.0)
        afwImage.Filter.define(afwImage.FilterProperty("g", filterPolicy))
            
    def tearDown(self):
        del self.smallExposure
        del self.wcs
        del self.psf

        del self.exposureBlank
        del self.exposureMiOnly
        del self.exposureMiWcs
        del self.exposureCrWcs
        del self.exposureCrOnly

    def testGetMaskedImage(self):
        """
        Test to ensure a MaskedImage can be obtained from each
        Exposure. An Exposure is required to have a MaskedImage,
        therefore each of the Exposures should return a MaskedImage.

        MaskedImage class should throw appropriate
        lsst::pex::exceptions::NotFound if the MaskedImage can not be
        obtained.
        """
        maskedImageBlank = self.exposureBlank.getMaskedImage()
        blankWidth = maskedImageBlank.getWidth()
        blankHeight = maskedImageBlank.getHeight()
        if blankWidth != blankHeight != 0:
            self.fail("%s = %s != 0" % (blankWidth, blankHeight))
        
        maskedImageMiOnly = self.exposureMiOnly.getMaskedImage()
        miOnlyWidth = maskedImageMiOnly.getWidth()
        miOnlyHeight = maskedImageMiOnly.getHeight()
        self.assertAlmostEqual(miOnlyWidth, self.width)
        self.assertAlmostEqual(miOnlyHeight, self.height)
        
        # NOTE: Unittests for Exposures created from a MaskedImage and
        # a WCS object are incomplete.  No way to test the validity of
        # the WCS being copied/created.
        
        maskedImageMiWcs = self.exposureMiWcs.getMaskedImage()
        miWcsWidth = maskedImageMiWcs.getWidth()
        miWcsHeight = maskedImageMiWcs.getHeight()
        self.assertAlmostEqual(miWcsWidth, self.width)
        self.assertAlmostEqual(miWcsHeight, self.height)
       
        maskedImageCrWcs = self.exposureCrWcs.getMaskedImage()
        crWcsWidth = maskedImageCrWcs.getWidth()
        crWcsHeight = maskedImageCrWcs.getHeight()
        if crWcsWidth != crWcsHeight != 0:
            self.fail("%s != %s != 0" % (crWcsWidth, crWcsHeight))
        
        maskedImageCrOnly = self.exposureCrOnly.getMaskedImage()
        crOnlyWidth = maskedImageCrOnly.getWidth()
        crOnlyHeight = maskedImageCrOnly.getHeight()
        if crOnlyWidth != crOnlyHeight != 0:
            self.fail("%s != %s != 0" % (crOnlyWidth, crOnlyHeight))

        # Check Exposure.getWidth() returns the MaskedImage's width
        self.assertEqual(crOnlyWidth, self.exposureCrOnly.getWidth())
        self.assertEqual(crOnlyHeight, self.exposureCrOnly.getHeight())

    def testGetWcs(self):
        """
        Test if a WCS can be obtained from each Exposure created with
        a WCS.
    
        Test that appropriate exceptions are thrown if a WCS is
        requested from an Exposure that was not created with a WCS.
        Python turns the pex::exceptions in the Exposure and
        MaskedImage classes into IndexErrors.

        The exposureBlank, exposureMiOnly, and exposureCrOnly
        Exposures should throw a lsst::pex::exceptions::NotFound.
        """

        self.assertTrue(not self.exposureBlank.getWcs())
        self.assertTrue(not self.exposureMiOnly.getWcs())

        # These two should pass
        self.exposureMiWcs.getWcs()
        self.exposureCrWcs.getWcs()
       
        self.assertTrue(not self.exposureCrOnly.getWcs())
            
    def testSetMembers(self):
        """
        Test that the MaskedImage and the WCS of an Exposure can be set.
        """
        exposure = afwImage.ExposureF()

        maskedImage = afwImage.MaskedImageF(inFilePathSmall)
        exposure.setMaskedImage(maskedImage)
        exposure.setWcs(self.wcs)
        exposure.setDetector(cameraGeom.Detector(cameraGeom.Id(666)))
        exposure.setFilter(afwImage.Filter("g"))

        self.assertEquals(exposure.getDetector().getId().getSerial(), 666)
        self.assertEquals(exposure.getFilter().getName(), "g")
        
        try:
            exposure.getWcs()
        except pexExcept.LsstCppException, e:
            print "caught expected exception (getWcs): %s" % e
            pass
        #
        # Test the Calib member.  The Calib tests are in color.py, here we just check that it's in Exposure
        #
        calib = exposure.getCalib()
        dt = 10
        calib.setExptime(dt)
        self.assertEqual(exposure.getCalib().getExptime(), dt)
        #
        # now check that we can set Calib
        #
        calib = afwImage.Calib()
        dt = 666
        calib.setExptime(dt)

        exposure.setCalib(calib)

        self.assertEqual(exposure.getCalib().getExptime(), dt)
        #
        # Psfs next
        #
        w, h = 11, 11
        self.assertFalse(exposure.hasPsf())
        exposure.setPsf(self.psf)
        self.assertTrue(exposure.hasPsf())

        exposure.setPsf(DummyPsf(1.0)) # we can reset the Psf
         
        # Test that we can set the MaskedImage and WCS of an Exposure
        # that already has both
        self.exposureMiWcs.setMaskedImage(maskedImage)
        exposure.setWcs(self.wcs)
       
    def testHasWcs(self):
        """
        Test if an Exposure has a WCS or not.
        """
        self.assertFalse(self.exposureBlank.hasWcs())

        self.assertFalse(self.exposureMiOnly.hasWcs())
        self.assertTrue(self.exposureMiWcs.hasWcs())
        self.assertTrue(self.exposureCrWcs.hasWcs())
        self.assertFalse(self.exposureCrOnly.hasWcs())
       
    def testGetSubExposure(self):
        """
        Test that a subExposure of the original Exposure can be obtained.

        The MaskedImage class should throw a
        lsst::pex::exceptions::InvalidParameter if the requested
        subRegion is not fully contained within the original
        MaskedImage.
        
        """
        #
        # This subExposure is valid
        #
        subBBox = afwGeom.Box2I(afwGeom.Point2I(40, 50), afwGeom.Extent2I(10, 10))
        subExposure = self.exposureCrWcs.Factory(self.exposureCrWcs, subBBox, afwImage.LOCAL)
        
        self.checkWcs(self.exposureCrWcs, subExposure)

        # this subRegion is not valid and should trigger an exception
        # from the MaskedImage class and should trigger an exception
        # from the WCS class for the MaskedImage 871034p_1_MI.
        
        subRegion3 = afwGeom.Box2I(afwGeom.Point2I(100, 100), afwGeom.Extent2I(10, 10))
        def getSubRegion():
            self.exposureCrWcs.Factory(self.exposureCrWcs, subRegion3, afwImage.LOCAL)

        utilsTests.assertRaisesLsstCpp(self, pexExcept.LengthErrorException, getSubRegion)

        # this subRegion is not valid and should trigger an exception
        # from the MaskedImage class only for the MaskedImage small_MI.
        # small_MI (cols, rows) = (256, 256)

        subRegion4 = afwGeom.Box2I(afwGeom.Point2I(250, 250), afwGeom.Extent2I(10, 10))
        def getSubRegion():
            self.exposureCrWcs.Factory(self.exposureCrWcs, subRegion4, afwImage.LOCAL)

        utilsTests.assertRaisesLsstCpp(self, pexExcept.LengthErrorException, getSubRegion)

        #check the sub- and parent- exposures are using the same Wcs transformation
        subBBox = afwGeom.Box2I(afwGeom.Point2I(40, 50), afwGeom.Extent2I(10, 10))
        subExposure = self.exposureCrWcs.Factory(self.exposureCrWcs, subBBox, afwImage.LOCAL)
        parentPos = self.exposureCrWcs.getWcs().pixelToSky(0,0)
        
        parentPos = parentPos.getPosition()
        
        subExpPos = subExposure.getWcs().pixelToSky(0,0).getPosition()
        
        for i in range(2):
            self.assertAlmostEqual(parentPos[i], subExpPos[i], 9, "Wcs in sub image has changed")

    def testReadWriteFits(self):
        """Test readFits and writeFits.
        """
        # This should pass without an exception
        mainExposure = afwImage.ExposureF(inFilePathSmall)
        mainExposure.setDetector(cameraGeom.Detector(cameraGeom.Id(666)))
        
        subBBox = afwGeom.Box2I(afwGeom.Point2I(10, 10), afwGeom.Extent2I(40, 50))
        subExposure = mainExposure.Factory(mainExposure, subBBox, afwImage.LOCAL)
        self.checkWcs(mainExposure, subExposure)
        det = subExposure.getDetector()
        self.assertTrue(det)
        
        subExposure = afwImage.ExposureF(inFilePathSmall, subBBox)
        
        self.checkWcs(mainExposure, subExposure)
        
        # This should throw an exception
        def getExposure():
            afwImage.ExposureF(inFilePathSmallImage)
        
        utilsTests.assertRaisesLsstCpp(self, lsst.afw.fits.FitsError, getExposure)
        
        mainExposure.setPsf(self.psf)

        # Make sure we can write without an exception
        mainExposure.getCalib().setExptime(10)
        mainExposure.getCalib().setMidTime(dafBase.DateTime())
        midMjd = mainExposure.getCalib().getMidTime().get()
        fluxMag0, fluxMag0Err = 1e12, 1e10
        mainExposure.getCalib().setFluxMag0(fluxMag0, fluxMag0Err)

        mainExposure.writeFits(outFile)

        readExposure = type(mainExposure)(outFile)

        os.remove(outFile)
        #
        # Check the round-tripping
        #
        self.assertEqual(mainExposure.getFilter().getName(), readExposure.getFilter().getName())

        self.assertEqual(mainExposure.getCalib().getExptime(), readExposure.getCalib().getExptime())
        self.assertEqual(midMjd, readExposure.getCalib().getMidTime().get())
        self.assertEqual((fluxMag0, fluxMag0Err), readExposure.getCalib().getFluxMag0())

        psf = readExposure.getPsf()
        self.assert_(psf is not None)
        dummyPsf = DummyPsf.swigConvert(psf)
        self.assert_(dummyPsf is not None)
        self.assertEqual(dummyPsf.getValue(), self.psf.getValue())

    def checkWcs(self, parentExposure, subExposure):
        """Compare WCS at corner points of a sub-exposure and its parent exposure
           By using the function indexToPosition, we should be able to convert the indices
           (of the four corners (of the sub-exposure)) to positions and use the wcs
           to get the same sky coordinates for each.
        """
        subMI = subExposure.getMaskedImage()
        subDim = subMI.getDimensions()
        subXY0 = subMI.getXY0()

        # Note: pixel positions must be computed relative to XY0 when working with WCS
        mainWcs = parentExposure.getWcs()
        subWcs = subExposure.getWcs()

        for xSubInd in (0, subDim.getX()-1):
            for ySubInd in (0, subDim.getY()-1):
                p0 = mainWcs.pixelToSky(
                    afwImage.indexToPosition(xSubInd),
                    afwImage.indexToPosition(ySubInd),
                )
                p1 = subWcs.pixelToSky(
                    afwImage.indexToPosition(xSubInd),
                    afwImage.indexToPosition(ySubInd),
                )

    def cmpExposure(self, e1, e2):
        self.assertEqual(e1.getDetector(), e2.getDetector())
        self.assertEqual(e1.getFilter().getName(), e2.getFilter().getName())
        xy = afwGeom.Point2D(0, 0)
        self.assertEqual(e1.getWcs().pixelToSky(xy)[0], e2.getWcs().pixelToSky(xy)[0])
        self.assertEqual(e1.getCalib().getExptime(), e2.getCalib().getExptime())
        # check PSF identity
        if not e1.getPsf():
            self.assertFalse(e2.getPsf())
        else:
            psf1 = DummyPsf.swigConvert(e1.getPsf())
            psf2 = DummyPsf.swigConvert(e2.getPsf())
            self.assertEqual(psf1.getValue(), psf2.getValue())

    def testCopyExposure(self):
        """Copy an Exposure (maybe changing type)"""

        exposureU = afwImage.ExposureU(inFilePathSmall)
        exposureU.setWcs(self.wcs)
        exposureU.setDetector(cameraGeom.Detector(cameraGeom.Id(666)))
        exposureU.setFilter(afwImage.Filter("g"))
        exposureU.getCalib().setExptime(666)
        exposureU.setPsf(DummyPsf(4.0))

        exposureF = exposureU.convertF()
        self.cmpExposure(exposureF, exposureU)

        nexp = exposureF.Factory(exposureF, False)
        self.cmpExposure(exposureF, nexp)

        # Ensure that the copy was deep.
        # (actually this test is invalid since getDetector() returns a CONST_PTR)
        # cen0 = exposureU.getDetector().getCenterPixel()
        # x0,y0 = cen0
        # det = exposureF.getDetector()
        # det.setCenterPixel(afwGeom.Point2D(999.0, 437.8))
        # self.assertEqual(exposureU.getDetector().getCenterPixel()[0], x0)
        # self.assertEqual(exposureU.getDetector().getCenterPixel()[1], y0)
    
    def testDeepCopyData(self):
        """Make sure a deep copy of an Exposure has its own data (ticket #2625)
        """
        exp = afwImage.ExposureF(6, 7)
        mi = exp.getMaskedImage()
        mi.getImage().set(100)
        mi.getMask().set(5)
        mi.getVariance().set(200)
        miArrays = mi.getArrays()

        expCopy = exp.clone()
        miCopy = expCopy.getMaskedImage()
        miCopy.getImage().set(-50)
        miCopy.getMask().set(2)
        miCopy.getVariance().set(175)
        miCopyArrays = miCopy.getArrays()

        self.assertTrue(numpy.allclose(miCopy.getImage().getArray(), -50))
        self.assertTrue(numpy.all(miCopy.getMask().getArray() == 2))
        self.assertTrue(numpy.allclose(miCopy.getVariance().getArray(), 175))

        self.assertTrue(numpy.allclose(mi.getImage().getArray(), 100))
        self.assertTrue(numpy.all(mi.getMask().getArray() == 5))
        self.assertTrue(numpy.allclose(mi.getVariance().getArray(), 200))

    
    def testDeepCopySubData(self):
        """Make sure a deep copy of a subregion of an Exposure has its own data (ticket #2625)
        """
        exp = afwImage.ExposureF(6, 7)
        mi = exp.getMaskedImage()
        mi.getImage().set(100)
        mi.getMask().set(5)
        mi.getVariance().set(200)
        miArrays = mi.getArrays()

        bbox = afwGeom.Box2I(afwGeom.Point2I(1,0), afwGeom.Extent2I(5, 4))
        expCopy = exp.Factory(exp, bbox, afwImage.PARENT, True)
        miCopy = expCopy.getMaskedImage()
        miCopy.getImage().set(-50)
        miCopy.getMask().set(2)
        miCopy.getVariance().set(175)
        miCopyArrays = miCopy.getArrays()

        self.assertTrue(numpy.allclose(miCopy.getImage().getArray(), -50))
        self.assertTrue(numpy.all(miCopy.getMask().getArray() == 2))
        self.assertTrue(numpy.allclose(miCopy.getVariance().getArray(), 175))

        self.assertTrue(numpy.allclose(mi.getImage().getArray(), 100))
        self.assertTrue(numpy.all(mi.getMask().getArray() == 5))
        self.assertTrue(numpy.allclose(mi.getVariance().getArray(), 200))
    
    def testDeepCopyMetadata(self):
        """Make sure a deep copy of an Exposure has a deep copy of metadata (ticket #2568)
        """
        exp = afwImage.ExposureF(10, 10)
        expMeta = exp.getMetadata()
        expMeta.set("foo", 5)
        expCopy = exp.clone()
        expCopyMeta = expCopy.getMetadata()
        expCopyMeta.set("foo", 6)
        self.assertEqual(expCopyMeta.get("foo"), 6)
        self.assertEqual(expMeta.get("foo"), 5) # this will fail if the bug is present

    def testDeepCopySubMetadata(self):
        """Make sure a deep copy of a subregion of an Exposure has a deep copy of metadata (ticket #2568)
        """
        exp = afwImage.ExposureF(10, 10)
        expMeta = exp.getMetadata()
        expMeta.set("foo", 5)
        bbox = afwGeom.Box2I(afwGeom.Point2I(1,0), afwGeom.Extent2I(5, 5))
        expCopy = exp.Factory(exp, bbox, afwImage.PARENT, True)
        expCopyMeta = expCopy.getMetadata()
        expCopyMeta.set("foo", 6)
        self.assertEqual(expCopyMeta.get("foo"), 6)
        self.assertEqual(expMeta.get("foo"), 5) # this will fail if the bug is present

    def testMakeExposureLeaks(self):
        """Test for memory leaks in makeExposure (the test is in utilsTests.MemoryTestCase)"""
        m = afwImage.makeMaskedImage(afwImage.ImageU(afwGeom.Extent2I(10, 20)))
        e = afwImage.makeExposure(afwImage.makeMaskedImage(afwImage.ImageU(afwGeom.Extent2I(10, 20))))

    def testImageSlices(self):
        """Test image slicing, which generate sub-images using Box2I under the covers"""
        exp = afwImage.ExposureF(10, 20)
        mi = exp.getMaskedImage()
        mi[9, 19] = 10
        # N.b. Exposures don't support setting/getting the pixels so can't replicate e.g. Image's slice tests
        sexp = exp[1:4, 6:10]
        self.assertEqual(sexp.getDimensions(), afwGeom.ExtentI(3, 4))
        sexp = exp[..., -3:]
        self.assertEqual(sexp.getDimensions(), afwGeom.ExtentI(exp.getWidth(), 3))
        self.assertEqual(sexp.getMaskedImage().get(sexp.getWidth() - 1, sexp.getHeight() - 1),
                          exp.getMaskedImage().get( exp.getWidth() - 1,  exp.getHeight() - 1))

    def testConversionToScalar(self):
        """Test that even 1-pixel Exposures can't be converted to scalars"""
        im = afwImage.ExposureF(10, 20)

        self.assertRaises(TypeError, float, im) # only single pixel images may be converted
        self.assertRaises(TypeError, float, im[0,0]) # actually, can't convert (img, msk, var) to scalar

    def testReadMetadata(self):
        filename = "testExposureMetadata.fits"
        self.exposureCrWcs.getMetadata().set("FRAZZLE", True)
        # This will write the main metadata (inc. FRAZZLE) to the primary HDU, and the
        # WCS to subsequent HDUs, along with INHERIT=T.
        self.exposureCrWcs.writeFits(filename)
        # This should read the first non-empty HDU (i.e. it skips the primary), but
        # goes back and reads it if it finds INHERIT=T.  That should let us read
        # frazzle and the Wcs from the PropertySet returned by readMetadata.
        md = afwImage.readMetadata(filename)
        wcs = afwImage.makeWcs(md, True)
        self.assertEqual(wcs.getPixelOrigin(), self.wcs.getPixelOrigin())
        self.assertEqual(wcs.getSkyOrigin(), self.wcs.getSkyOrigin())
        self.assert_(numpy.all(wcs.getCDMatrix() == self.wcs.getCDMatrix()))
        frazzle = md.get("FRAZZLE")
        self.assert_(frazzle is True)
        os.remove(filename)

    def testArchiveKeys(self):
        filename = "testArchiveKeys.fits"
        exposure1 = afwImage.ExposureF(100, 100, self.wcs)
        exposure1.setPsf(self.psf)
        exposure1.writeFits(filename)
        exposure2 = afwImage.ExposureF(filename)
        self.assertFalse(exposure2.getMetadata().exists("AR_ID"))
        self.assertFalse(exposure2.getMetadata().exists("PSF_ID"))
        self.assertFalse(exposure2.getMetadata().exists("WCS_ID"))
        os.remove(filename)

    def testTicket2861(self):
        filename = "testTicket2861.fits"
        exposure1 = afwImage.ExposureF(100, 100, self.wcs)
        exposure1.setPsf(self.psf)
        schema = afwTable.ExposureTable.makeMinimalSchema()
        coaddInputs = afwImage.CoaddInputs(schema, schema)
        exposure1.getInfo().setCoaddInputs(coaddInputs)
        exposure2 = afwImage.ExposureF(exposure1, True)
        self.assertIsNotNone(exposure2.getInfo().getCoaddInputs())
        exposure2.writeFits(filename)
        exposure3 = afwImage.ExposureF(filename)
        self.assertIsNotNone(exposure3.getInfo().getCoaddInputs())
        os.remove(filename)
        

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

def suite():
    """
    Returns a suite containing all the test cases in this module.
    """
    utilsTests.init()

    suites = []
    suites += unittest.makeSuite(ExposureTestCase)
    suites += unittest.makeSuite(utilsTests.MemoryTestCase)

    return unittest.TestSuite(suites)

def run(shouldExit=False):
    """Run the tests"""
    utilsTests.run(suite(), shouldExit)

if __name__ == "__main__":
    run(True)
