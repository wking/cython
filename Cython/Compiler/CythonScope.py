from Binding import Binding
from Symtab import ModuleScope
from PyrexTypes import *

shape_func_type = CFuncType(
    c_ptr_type(c_py_ssize_t_type),
    [CFuncTypeArg("buffer", py_object_type, None)])

class CythonScope(ModuleScope):
    def __init__(self, context):
        ModuleScope.__init__(self, u'cython', None, context)
        self.pxd_file_loaded = True

        binding = Binding(name = 'shape', cname = '<error>')
        self.shape_entry = self.declare_cfunction(
            binding, type = shape_func_type, defining = 1)

    def lookup_type(self, name):
        # This function should go away when types are all first-level objects.
        type = parse_basic_type(name)
        if type:
            return type

def create_cython_scope(context):
    create_utility_scope(context)
    return CythonScope(context)


def create_utility_scope(context):
    global utility_scope
    utility_scope = ModuleScope(u'utility', None, context)

    # These are used to optimize isinstance in FinalOptimizePhase
    binding = Binding(name = 'PyTypeObject', cname = 'PyTypeObject')
    type_object = utility_scope.declare_typedef(
        binding, base_type = c_void_type, pos = None)
    type_object.is_void = True

    binding = Binding(
        name = 'PyObject_TypeCheck', cname = 'PyObject_TypeCheck')
    func_type = CFuncType(
        c_bint_type, [CFuncTypeArg("o", py_object_type, None),
                      CFuncTypeArg("t", c_ptr_type(type_object), None)])
    utility_scope.declare_cfunction(binding, type = func_type, defining = 1)

    return utility_scope
