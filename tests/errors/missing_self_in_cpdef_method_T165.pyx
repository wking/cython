
cdef class A:
    cpdef a(int not_self):
        pass

_ERRORS = u"""
3:4: Self argument (int) of C method 'a' does not match parent type (A)
"""
