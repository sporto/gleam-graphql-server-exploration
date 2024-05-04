// This contains static code in the library
import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}

pub type Object {
  Object(name: String, fields: List(Field))
}

pub type FieldOutput {
  FieldOutputScalarBoolean
  FieldOutputScalarFloat
  FieldOutputScalarInt
  FieldOutputScalarString
  FieldOutputObject(String)
  FieldOutputNullableObject(String)
  FieldOutputObjectList(String)
}

// Output of a field can be an object or a scalar
pub type Field {
  Field(name: String, args: Dict(String, String), output: FieldOutput)
}

pub type Schema {
  Schema(objects: List(Object), query: Object)
}

pub type ResolveFn =
  fn(String, Dynamic, Dynamic) -> Result(Dynamic, String)

pub type GraphQL {
  GraphQL(schema: Schema, resolve: ResolveFn)
}

pub fn execute_request() {
  todo
}
