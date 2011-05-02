# mode: error

cimport cython

@cython.final
cdef class FinalClass:
    pass

cdef class SubType(FinalClass):
    pass

_ERRORS = """
9:0: Base class 'FinalClass' of type 'SubType' is final
"""
