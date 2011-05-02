# mode: error

cdef class C:
	cdef void f(self):
		pass

cdef class D(C):
	cdef void f(self, int x):
		pass
_ERRORS = u"""
8:1: Signature not compatible with previous declaration
4:1: Previous declaration is here
"""
