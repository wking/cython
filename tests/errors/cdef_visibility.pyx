# mode: error

# TODO: a way to keep going after parsing errors?

cdef private int priv_global_variable

cdef private priv_global_function(x):
    return x*2


cdef class bare_global_class:
    cdef private int priv_attribute

    def __cinit__(self):
        self.priv_attribute = 1


cdef class public pub_global_class:
    cpdef cp_method(self, x):
        return x*2


cdef class private priv_global_class:
    cpdef cp_method(self, x):
        return x*2


cdef class readonly ro_global_class:
    cpdef cp_method(self, x):
        return x*2


cpdef class cp_global_class:
    cpdef cp_method(self, x):
        return x*2


_ERRORS = u"""
5:17: Syntax error in C variable declaration
"""
