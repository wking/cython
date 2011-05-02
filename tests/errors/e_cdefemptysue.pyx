# mode: error

cdef struct spam:
	pass

ctypedef union eggs:
	pass

cdef enum ham:
	pass
_ERRORS = u"""
3:0: Empty struct or union definition not allowed outside a 'cdef extern from' block
6:0: Empty struct or union definition not allowed outside a 'cdef extern from' block
9:0: Empty enum definition not allowed outside a 'cdef extern from' block
"""
