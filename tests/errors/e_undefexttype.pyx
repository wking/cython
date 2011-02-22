cdef class Spam
cdef extern class external.Eggs
_ERRORS = u"""
1:0: C class 'Spam' is declared but not defined
2:0: C class 'Eggs' is declared but not defined
"""
