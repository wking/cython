__doc__ = u"""

Due to module-level entries being Python objects, we cannot enforce
any visibility flags for the entries.  Perhaps they should raise
errors on compilation to avoid suprises?  We should still hide the
private ones, as we do with functions.

>>> bare_global_variable = 1
>>> print bare_global_variable
1
>>> bare_global_variable = 'one'
>>> bare_global_variable
'one'
>>> pub_global_variable = 1
>>> print pub_global_variable
1
>>> pub_global_variable = 'one'
>>> pub_global_variable
'one'
>>> priv_global_variable = 1
>>> print priv_global_variable
1
>>> priv_global_variable = 'one'
>>> priv_global_variable
'one'
>>> ro_global_variable = 1
>>> print ro_global_variable
1
>>> ro_global_variable = 'one'
>>> ro_global_variable
'one'
>>> cp_global_variable = 1
>>> print cp_global_variable
1
>>> cp_global_variable = 'one'
>>> cp_global_variable
'one'

>>> print bare_global_function(1)
Traceback (most recent call last):
NameError: name 'bare_global_function' is not defined
>>> bare_global_function = 'one'
>>> bare_global_function
'one'
>>> print pub_global_function(1)
Traceback (most recent call last):
NameError: name 'pub_global_function' is not defined
>>> pub_global_function = 'one'
>>> pub_global_function
'one'
>>> #print priv_global_function(1)
>>> #priv_global_function = lambda x: x*3
>>> print ro_global_function(1)
Traceback (most recent call last):
NameError: name 'ro_global_function' is not defined
>>> ro_global_function = 'one'
>>> ro_global_function
'one'
>>> print cp_global_function(1)
2
>>> cp_global_function = 'one'
>>> cp_global_function
'one'

>>> x = bare_global_class()
>>> #x = pub_global_class()
>>> #x = priv_global_class()
>>> #x = ro_global_class()
>>> #x = cp_global_class()

>>> x = bare_global_class()

>>> print x.bare_attribute
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'bare_attribute'
>>> x.bare_attribute = 2
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'bare_attribute'
>>> print x.bare_attribute
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'bare_attribute'

>>> print x.pub_attribute
1
>>> x.pub_attribute = 2
>>> print x.pub_attribute
2
>>> x.pub_attribute = 'one'
Traceback (most recent call last):
TypeError: an integer is required
>>> x.pub_attribute
2

>>> print x.priv_attribute
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'priv_attribute'
>>> x.priv_attribute = 2
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'priv_attribute'

>>> print x.ro_attribute
1
>>> x.ro_attribute = 2
Traceback (most recent call last):
AttributeError: attribute 'ro_attribute' of 'cdef_visibility.bare_global_class' objects is not writable
>>> print x.ro_attribute
1

>>> print x.cp_attribute
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'cp_attribute'
>>> x.cp_attribute = 2
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'cp_attribute'


>>> print x.bare_method(1)
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'bare_method'
>>> x.bare_method = 'one'
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'bare_method'

>>> print x.pub_method(1)
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'pub_method'
>>> x.pub_method = 'one'
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'pub_method'

>>> #print x.priv_method(1)
>>> #x.priv_method = 'one'
>>> #print x.priv_method(1)

>>> print x.ro_method(1)
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'ro_method'
>>> x.ro_method = 'one'
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object has no attribute 'ro_method'

>>> print x.cp_method(1)
2
>>> x.cp_method = 'one'
Traceback (most recent call last):
AttributeError: 'cdef_visibility.bare_global_class' object attribute 'cp_method' is read-only
>>> print x.cp_method(1)
2
"""

cdef int bare_global_variable
cdef public int pub_global_variable
cdef readonly int ro_global_variable
cpdef int cp_global_variable

cdef bare_global_function(x):
    return x*2

cdef public pub_global_function(x):
    return x*2

cdef readonly ro_global_function(x):
    return x*2

cpdef cp_global_function(x):
    return x*2


cdef class bare_global_class:
    cdef int bare_attribute
    cdef public int pub_attribute
    cdef readonly int ro_attribute
    cpdef int cp_attribute

    def __cinit__(self):
        self.bare_attribute = 1
        self.pub_attribute = 1
        self.ro_attribute = 1
        self.cp_attribute = 1

    cdef bare_method(self, x):
        return x*2
    
    cdef public pub_method(self, x):
        return x*2
    
    cdef readonly ro_method(self, x):
        return x*2
    
    cpdef cp_method(self, x):
        return x*2
