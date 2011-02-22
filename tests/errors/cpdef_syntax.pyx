
cpdef nogil: pass
cpdef nogil class test: pass

_ERRORS = u"""
 2: 0: cdef blocks cannot be declared cpdef
 3: 0: cdef blocks cannot be declared cpdef
 3:12: Expected ':', found 'class'
"""
