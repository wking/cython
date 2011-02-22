cdef extern:
    cdef packed struct MyStruct:
        char a

_ERRORS = u"""
2:4: Cannot declare extern struct as 'packed'
"""
