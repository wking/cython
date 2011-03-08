#
#    Classes defining binding interfaces.
#


class _BindingAttributes(object):
    """Base class for complicated binding attributes.

    This class allows us to define methods for generating child
    contexts and pushing/pulling well-defined attribute sets.

    Pushes, pulls, and deepcopies are simplified by assuming that all
    relevant attribute values are immutable.
    """
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)

    def deepcopy(self, **kwargs):
        "Return a copy of `self` preserving all attributes."
        cls = type(self)
        cpy = cls()
        self.push(cpy)
        cpy.__dict__.update(kwargs)
        return cpy

    def push(self, other):
        """Push all of `self`'s attributes onto `other`

        Remember that attributes that aren't in `self.__dict__`
        (e.g. uninitialized, class-wide defaults) will *not* be
        copied.
        """
        other.__dict__.update(self.__dict__)

    def pull(self, other):
        """Pull all relevant attributes from `other`

        Remember that attributes that aren't in `self.__dict__`
        (e.g. uninitialized, class-wide defaults) will *not* be
        copied.
        """
        for key,value in other.__dict__.iteritems():
            if key in dir(self):
                self.__dict__[key] = value


class CBinding(_BindingAttributes):
    """Configure the presence and behaviour of an object's C bindings.

    * cname (string): Generated symbol name (or source name, is the
      symbol is external.
    * namespace (string): C++ namespace of the source (`None` for C
      objects, set if the symbol is external)
    * cdef_flag (boolean): Symbol (data) has a C definition.
    * visibility ('private'|'public'|'extern'|'ignore'):

      * private: Symbol is not accessible to external C code
      * public: Symbol is accessible to external C code
      * extern: Symbol is defined elsewhere (otherwise a local
        definition is created).
      * ignore: ? something about symbol re-definition?

    * const (boolean): Symbol data is readonly.
    * api (boolean): Add to generated header file
    """
    cname = None
    namespace = None
    cdef_flag = 0
    c_visibility = 'private'
    const = 0
    api = 0


class PythonBinding(_BindingAttributes):
    """Configure the presence and behaviour of an object's Python bindings.

    * name (string): Name to which the object is bound (if the object
      is visible)
    * visibility ('private'|'public'|'readonly'):

      * private: Object is not exposed to Python code.
      * public: Python can read/write to the object's data.
      * readonly: Python can read (but nut write) the object's data.

    * overridable (boolean): Python references can be overridden in
      Python (if the object is visible).  This is only supported in
      class methods.
    """
    name = None
    visibility = 'public'
    overridable = 0


class Binding(CBinding, PythonBinding):
    "Combine all binding attributes in a single, flat namespace."
    def visibility_string(self):
        "Summarize binding visibility in a single string"
        return 'C: %s, Python: %s' % (
            self.c_visibility, self.visibility)
