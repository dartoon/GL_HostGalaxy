// -*- lsst-c++ -*-
#ifndef AFW_TABLE_IO_Writer_h_INCLUDED
#define AFW_TABLE_IO_Writer_h_INCLUDED

#include <set>

#include "lsst/base.h"
#include "lsst/pex/exceptions.h"
#include "lsst/afw/table/BaseTable.h"

namespace lsst { namespace afw { namespace table {

class BaseRecord;

namespace io {

/**
 *  @brief Write a container of records to disk (or elsewhere).
 *
 *  An instance of Writer is associated with a particular file or storage location,
 *  and can be invoked by calling write() with a container.
 *
 *  Writer contains driver code that should work for most input operations and record
 *  containers, and delegates the real work to protected member functions.  Writer does
 *  not specify how it will be constructed.
 */
class Writer {
public:

    /**
     *  @brief Write records in a container to disk (or elsewhere).
     *
     *  The given container must have a getTable() member function that returns a shared_ptr
     *  to a table, and the iterators returned by begin() and end() must dereference to a type
     *  convertible to BaseRecord const &.
     */
    template <typename ContainerT>
    void write(ContainerT const & container) {
        std::set<PTR(BaseTable const)> tables;
        for (typename ContainerT::const_iterator i = container.begin(); i != container.end(); ++i) {
            if (i->getTable() != container.getTable()) tables.insert(i->getTable());
        }
        for (std::set<PTR(BaseTable const)>::iterator j = tables.begin(); j != tables.end(); ++j) {
            if (
                (**j).getSchema().compare(container.getTable()->getSchema(), Schema::IDENTICAL)
                != Schema::IDENTICAL
            ) {
                throw LSST_EXCEPT(
                    pex::exceptions::LogicErrorException,
                    "Cannot save Catalog with heterogenous schemas"
                );
            }
        }
        _writeTable(container.getTable(), container.size());
        for (typename ContainerT::const_iterator i = container.begin(); i != container.end(); ++i) {
            _writeRecord(*i);
        }
        _finish();
    }
    
    virtual ~Writer() {}

protected:

    /// @brief Write a table and its schema.
    virtual void _writeTable(CONST_PTR(BaseTable) const & table, std::size_t nRows) = 0;

    /// @brief Write an individual record.
    virtual void _writeRecord(BaseRecord const & record) = 0;

    /// @brief Finish writing a catalog.
    virtual void _finish() {}
};

}}}} // namespace lsst::afw::table::io

#endif // !AFW_TABLE_IO_Writer_h_INCLUDED
