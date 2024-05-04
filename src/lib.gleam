// This contains static code in the library
import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}

// type Scalar {
//   ScalarBoolean
//   ScalarFloat
//   ScalarInt
//   ScalarString
//   ScalarID
// }

pub type Object {
  Object(name: String, fields: List(Field))
}

// Output of a field can be an object or a scalar
pub type Field {
  Field(name: String, args: Dict(String, String), output: String)
}

pub type Schema {
  Schema(objects: List(Object), query: Object)
}

pub type ResolveFn =
  fn(String, Dynamic, Dynamic) -> Result(Dynamic, String)

pub type GraphQL {
  GraphQL(schema: Schema, resolve: ResolveFn)
}
