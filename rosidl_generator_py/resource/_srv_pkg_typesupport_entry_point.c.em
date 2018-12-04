@# Included from rosidl_generator_py/resource/_idl_pkg_typesupport_entry_point.c.em
@{
TEMPLATE(
    '_msg_pkg_typesupport_entry_point.c.em',
    package_name=package_name, message=service.request_message,
    typesupport_impl=typesupport_impl, include_directives=include_directives)
}@

@{
TEMPLATE(
    '_msg_pkg_typesupport_entry_point.c.em',
    package_name=package_name, message=service.response_message,
    typesupport_impl=typesupport_impl, include_directives=include_directives)
}@
@
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
type_name = convert_camel_case_to_lower_case_underscore(service.structure_type.name)
function_name = 'type_support'
}@

ROSIDL_GENERATOR_C_IMPORT
const rosidl_service_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(rosidl_typesupport_c, @(', '.join(service.structure_type.namespaces + [service.structure_type.name])))();

int8_t
_register_srv_type__@('__'.join(service.structure_type.namespaces[1:] + [type_name]))(PyObject * pymodule)
{
  int8_t err;
  PyObject * pyobject_@(function_name) = NULL;
  pyobject_@(function_name) = PyCapsule_New(
    (void *)ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(rosidl_typesupport_c, @(', '.join(service.structure_type.namespaces + [service.structure_type.name])))(),
    NULL, NULL);
  if (!pyobject_@(function_name)) {
    // previously added objects will be removed when the module is destroyed
    return -1;
  }
  err = PyModule_AddObject(
    pymodule,
    "@(function_name)_srv__@('_'.join(service.structure_type.namespaces[1:] + [type_name]))",
    pyobject_@(function_name));
  if (err) {
    // the created capsule needs to be decremented
    Py_XDECREF(pyobject_@(function_name));
    // previously added objects will be removed when the module is destroyed
    return err;
  }
  return 0;
}
