# mode: error

cdef class C:
    cdef void f(self):
        pass

cdef class D(C):
    cdef void f(self, int x):
        pass

_ERRORS = u"""
8: 4: Signature not compatible with previous declaration
4: 4: Previous declaration is here
"""
