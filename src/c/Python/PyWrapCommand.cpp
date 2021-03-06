// Setup for defining wrapped commands
#include "PyWrapCommand.h"

#define INSTANCE_COMMANDS
#include "PyWrapDef.h"
#include "../WrapCmds/CommandList.h"
#undef INSTANCE_COMMANDS

#define BUILD_COMMANDS
#include "PyWrapDef.h"
#include "../WrapCmds/CommandList.h"
#undef BUILD_COMMANDS


template <typename T, typename U>
void converter(void* in, void* out, std::size_t len)
{
	for ( int i=0; i < len; ++i )
		((U*)out)[i] = static_cast<U>(((T*)in)[i]);
}

bool Script::pyarrayToVec(PyArrayObject* ar, Vec<double>& outVec)
{
	int ndim = PyArray_NDIM(ar);
	if ( ndim > 1 )
		return false;

	std::size_t array_size = PyArray_DIM(ar, 0);
	if ( array_size != 3 )
		return false;

	if ( PyArray_TYPE(ar) == NPY_UINT8 )
		converter<uint8_t,double>(PyArray_DATA(ar), outVec.e, array_size);
	else if ( PyArray_TYPE(ar) == NPY_UINT16 )
		converter<uint16_t, double>(PyArray_DATA(ar), outVec.e, array_size);
	else if ( PyArray_TYPE(ar) == NPY_INT16 )
		converter<int16_t, double>(PyArray_DATA(ar), outVec.e, array_size);
	else if ( PyArray_TYPE(ar) == NPY_UINT32 )
		converter<uint32_t, double>(PyArray_DATA(ar), outVec.e, array_size);
	else if ( PyArray_TYPE(ar) == NPY_INT32 )
		converter<int32_t, double>(PyArray_DATA(ar), outVec.e, array_size);
	else if ( PyArray_TYPE(ar) == NPY_FLOAT )
		converter<float, double>(PyArray_DATA(ar), outVec.e, array_size);
	else if ( PyArray_TYPE(ar) == NPY_DOUBLE )
		converter<double, double>(PyArray_DATA(ar), outVec.e, array_size);

	return true;
}


bool Script::pylistToVec(PyObject* list, Vec<double>& outVec)
{
	Py_ssize_t list_size = PyList_Size(list);
	if ( list_size != 3 )
		return false;

	for ( int i=0; i < list_size; ++i )
	{
		PyObject* item = PyList_GetItem(list, i);
		if ( PyLong_Check(item) )
			outVec.e[i] = PyLong_AsDouble(item);
		else if ( PyFloat_Check(item) )
			outVec.e[i] = PyFloat_AsDouble(item);
		else
			return false;
	}

	return true;
}


bool Script::pyobjToVec(PyObject* list_array, Vec<double>& outVec)
{
	if ( PyList_Check(list_array) )
		return pylistToVec(list_array, outVec);

	else if ( PyArray_Check(list_array) )
		return pyarrayToVec((PyArrayObject*)list_array, outVec);

	return false;
}


// Info Command (unimplemented)
const char PyWrapInfo::docString[] = "Not implemented for Python bindings.";
PyObject* PyWrapInfo::execute(PyObject* self, PyObject* args)
{
	PyErr_SetString(PyExc_RuntimeWarning, "Info() not implemented for Python!");
	return nullptr;
}

// Help Command (unimplemented)
const char PyWrapHelp::docString[] = "Not implemented for Python bindings.";
PyObject* PyWrapHelp::execute(PyObject* self, PyObject* args)
{
	PyErr_SetString(PyExc_RuntimeWarning, "Help() not implemented for Python!");
	return nullptr;
}