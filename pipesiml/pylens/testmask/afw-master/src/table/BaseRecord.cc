// -*- lsst-c++ -*-

#include <cstring>

#include "lsst/pex/exceptions.h"
#include "lsst/afw/table/BaseRecord.h"
#include "lsst/afw/table/SchemaMapper.h"

namespace lsst { namespace afw { namespace table {

namespace {

// A SchemaMapper::forEach functor that copies data from one record to another.
struct CopyValue {

    template <typename U>
    void operator()(Key<U> const & inputKey, Key<U> const & outputKey) const {
        typename Field<U>::Element const * inputElem = _inputRecord->getElement(inputKey);
        std::copy(inputElem, inputElem + inputKey.getElementCount(), _outputRecord->getElement(outputKey));
    }

    void operator()(Key<Flag> const & inputKey, Key<Flag> const & outputKey) const {
        _outputRecord->set(outputKey, _inputRecord->get(inputKey));
    }

    CopyValue(BaseRecord const * inputRecord, BaseRecord * outputRecord) :
        _inputRecord(inputRecord), _outputRecord(outputRecord)
    {}

private:
    BaseRecord const * _inputRecord;
    BaseRecord * _outputRecord;
};

} // anonymous

void BaseRecord::assign(BaseRecord const & other) {
    if (this->getSchema() != other.getSchema()) {
        throw LSST_EXCEPT(
            lsst::pex::exceptions::LogicErrorException,
            "Unequal schemas in record assignment."
        );
    }
    // Schemas are identical and they're all POD, so we can just copy the raw data.
    std::memcpy(_data, other._data, this->getSchema().getRecordSize());
    this->_assign(other); // let derived classes assign their own stuff
}

void BaseRecord::assign(BaseRecord const & other, SchemaMapper const & mapper) {
    if (!other.getSchema().contains(mapper.getInputSchema())) {
        throw LSST_EXCEPT(
            lsst::pex::exceptions::LogicErrorException,
            "Unequal schemas between input record and mapper."
        );
    }
    if (!this->getSchema().contains(mapper.getOutputSchema())) {
        throw LSST_EXCEPT(
            lsst::pex::exceptions::LogicErrorException,
            "Unequal schemas between output record and mapper."
        );
    }
    mapper.forEach(CopyValue(&other, this)); // use the functor we defined above
    this->_assign(other); // let derived classes assign their own stuff
}

}}} // namespace lsst::afw::table
