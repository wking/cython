cdef class C:
    cdef void f(self):
        pass

_ERRORS = u"""
2:4: Signature not compatible with previous declaration
2:15: Previous declaration is here
"""
