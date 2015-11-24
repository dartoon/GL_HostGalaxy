// -*- LSST-C++ -*- // fixed format comment for emacs
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

#include "lsst/afw/image/CoaddInputs.h"
#include "lsst/afw/table/io/InputArchive.h"
#include "lsst/afw/table/io/CatalogVector.h"

namespace lsst { namespace afw { namespace image {

namespace {

class CoaddInputsFactory : public table::io::PersistableFactory {
public:

    virtual PTR(table::io::Persistable)
    read(InputArchive const & archive, CatalogVector const & catalogs) const {
        LSST_ARCHIVE_ASSERT(catalogs.size() == 2);
        PTR(CoaddInputs) result = boost::make_shared<CoaddInputs>();
        result->visits = table::ExposureCatalog::readFromArchive(archive, catalogs.front());
        result->ccds = table::ExposureCatalog::readFromArchive(archive, catalogs.back());
        return result;
    }

    CoaddInputsFactory(std::string const & name) : table::io::PersistableFactory(name) {}

};

CoaddInputsFactory registration("CoaddInputs");

} // anonymous

CoaddInputs::CoaddInputs() : visits(), ccds() {}

CoaddInputs::CoaddInputs(table::Schema const & visitSchema, table::Schema const & ccdSchema) :
    visits(visitSchema), ccds(ccdSchema)
{}

CoaddInputs::CoaddInputs(table::ExposureCatalog const & visits_, table::ExposureCatalog const & ccds_) :
    visits(visits_), ccds(ccds_)
{}

bool CoaddInputs::isPersistable() const { return true; }

std::string CoaddInputs::getPersistenceName() const { return "CoaddInputs"; }

std::string CoaddInputs::getPythonModule() const { return "lsst.afw.image"; }

void CoaddInputs::write(OutputArchiveHandle & handle) const {
    visits.writeToArchive(handle, true); // true == permissive - just ignore Psfs, Wcss that can't be saved
    ccds.writeToArchive(handle, true);
}

}}} // namespace lsst::afw::image
