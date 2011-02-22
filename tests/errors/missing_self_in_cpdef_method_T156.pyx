
cdef class B:
    cpdef b():
        pass

_ERRORS = u"""
3:4: C method has no self argument
"""
