# mode: compile

cdef class A:
    cdef public int i
    cdef readonly int j
    cdef void *ptr

    cpdef a(self):
        ma(self)

cpdef ma(x):
    print x

cdef struct S:
    cdef public int i
    cdef readonly int j
    cdef void *ptr

cdef union S:
    cdef public int i
    cdef readonly unsigned int j
    cdef void *ptr

cdef enum E:
    cdef public i
    cdef readonly j
    k
