#
#    Classes defining binding interfaces.
#


class CtxAttribute(object):
    """Base class for complicated Ctx attributes.

    Having a single base class makes it easier to generate child
    contexts.
    """
    def deepcopy(self):
        cls = type(self)
        cpy = cls()
        cpy.__dict__.update(self.__dict__)
        return cpy


class CSource(CtxAttribute):
    """Configure the location of an object's C source.

    * name (string): Source symbol name (if the symbol is external)
    * namespace (string): C++ namespace (`None` for C objects, set if
      the symbol is external)
    * cdef_flag (boolean): Symbol (data) has a C definition.
    * extern (boolean): Symbol is defined elsewhere (otherwise a local
      defition is created).
    """
    name = None
    namespace = None
    cdef_flag = 0
    extern = 0


class CBinding(CtxAttribute):
    """Configure the presence and behaviour of an object's C bindings.

    * name (string): Generated symbol name
    * namespace (string): C++ namespace (`None` for C objects)
    * api (boolean): Add to generated header file
    * visibility ('private'|'public'):

      * private: Symbol is not accessible to external C code
      * public: Symbol is accessible to external C code

    * const (boolean): Symbol data is readonly.
    """
    name = None
    namespace = None
    api = 0
    visibility = 'private'
    const = 0


class PythonBinding(CtxAttribute):
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
    visibility = 'public' #private'
    overridable = 0
