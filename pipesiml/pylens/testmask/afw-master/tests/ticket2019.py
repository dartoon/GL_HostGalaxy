import os, sys, unittest
import lsst.utils.tests as utilsTests
import lsst.afw.detection as afwDet
import lsst.afw.image as afwImage
import lsst.afw.table as afwTable
import lsst.afw.geom as afwGeom

class SourceHeavyFootprintTestCase(unittest.TestCase):
    def test1(self):
        im = afwImage.ImageF(100, 100)
        im += 42.
        fp = afwDet.Footprint(afwGeom.Point2I(50,50), 10.)
        #seed = 42
        #rand = afwMath.Random(afwMath.Random.MT19937, seed)
        #afwMath.randomGaussianImage(im, rand)
        mi = afwImage.MaskedImageF(im)
        # set a mask bit before grabbing the heavyfootprint
        mi.getMask().set(50, 50, 1)
        heavy = afwDet.makeHeavyFootprint(fp, mi)
        # reset it
        mi.getMask().set(50, 50, 0)

        schema = afwTable.SourceTable.makeMinimalSchema()
        table = afwTable.SourceTable.make(schema)
        table.preallocate(10)
        catalog = afwTable.SourceCatalog(table)
        catalog.addNew()
        # This used to segfault
        catalog[0].setFootprint(heavy)

        # However, we still have to up-cast
        fp = catalog[0].getFootprint()
        hfp = afwDet.cast_HeavyFootprintF(fp)
        # change one pixel...
        self.assertEqual(mi.getImage().get(50, 50), 42)
        self.assertEqual(mi.getMask().get(50, 50), 0)
        mi.getImage().set(50, 50, 100)
        mi.getMask().set(50, 50, 2)
        mi.getMask().set(51, 50, 2)
        self.assertEqual(mi.getImage().get(50, 50), 100)
        self.assertEqual(mi.getMask().get(50, 50), 2)
        self.assertEqual(mi.getMask().get(51, 50), 2)
        # reinsert the heavy footprint; it should reset the pixel value.
        # insert(MaskedImage)
        hfp.insert(mi)
        self.assertEqual(mi.getImage().get(50, 50), 42)
        self.assertEqual(mi.getMask().get(50, 50), 1)
        self.assertEqual(mi.getMask().get(51, 50), 0)

        # Also test insert(Image)
        im = mi.getImage()
        self.assertEqual(im.get(50, 50), 42)
        im.set(50, 50, 100)
        self.assertEqual(im.get(50, 50), 100)
        self.assertEqual(mi.getImage().get(50, 50), 100)
        # reinsert the heavy footprint; it should reset the pixel value.
        hfp.insert(im)
        self.assertEqual(im.get(50, 50), 42)
        self.assertEqual(mi.getImage().get(50, 50), 42)
        self.assertEqual(mi.getMask().get(50, 50), 1)
        self.assertEqual(mi.getMask().get(51, 50), 0)

            
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

def suite():
    """Returns a suite containing all the test cases in this module."""

    utilsTests.init()

    suites = []
    suites += unittest.makeSuite(SourceHeavyFootprintTestCase)
    suites += unittest.makeSuite(utilsTests.MemoryTestCase)
    return unittest.TestSuite(suites)

def run(shouldExit = False):
    """Run the tests"""
    utilsTests.run(suite(), shouldExit)

if __name__ == "__main__":
    run(True)

        
        

        
