# mode: error

cdef class C:
	cdef void f(self) nogil:
		pass

_ERRORS = u"""
2:12: Previous declaration is here
4: 1: Signature not compatible with previous declaration
"""
