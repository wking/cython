
cimport cython

@cython.final
cdef class FinalClass:
    pass

cdef class SubType(FinalClass):
    pass

_ERRORS = """
8:0: Base class 'FinalClass' of type 'SubType' is final
"""
