
# current restriction: cannot inherit from PyVarObject (see ticket #152)

cdef class MyTuple(tuple):
    pass

cdef class MyBytes(bytes):
    pass

cdef class MyStr(str): # only in Py2, but can't know that during compilation
    pass

_ERRORS = """
4:0: inheritance from PyVarObject types like 'tuple' is not currently supported
7:0: inheritance from PyVarObject types like 'bytes' is not currently supported
10:0: inheritance from PyVarObject types like 'str' is not currently supported
"""
