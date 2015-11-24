from lsst.afw.fits.fitsLib import MemFileManager, cdata, memmove

def reduceToFits(obj):
    """Pickle to FITS

    Intended to be used by the __reduce__ method of a class.

    Assumes the existence of a "writeFits" method on the object.
    """
    manager = MemFileManager()
    obj.writeFits(manager)
    size = manager.getLength()
    data = cdata(manager.getData(), size);
    return (unreduceFromFits, (obj.__class__, data, size))

def unreduceFromFits(cls, data, size):
    """Unpickle from FITS

    Unpacks data produced by reduceToFits.

    Assumes the existence of a "readFits" method on the object.
    """
    manager = MemFileManager(size)
    memmove(manager.getData(), data)
    return cls.readFits(manager)
