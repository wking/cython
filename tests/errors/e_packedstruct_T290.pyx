# ticket: 290
# mode: error

cdef extern:
    cdef packed struct MyStruct:
        char a

_ERRORS = u"""
5:4: Cannot declare extern struct as 'packed'
"""
