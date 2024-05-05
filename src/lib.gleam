// This contains static code in the library
import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}
import gleam/list
import gleam/result

pub type Object {
  Object(name: String, fields: List(Field))
}

pub type Field {
  Field(name: String, resolve: FieldResolveFn)
}

type FieldResolveFn =
  fn(Dynamic, Dynamic) -> Result(Dynamic, String)

pub fn object(name name: String, fields fields: List(Field)) -> Object {
  Object(name: name, fields: fields)
}

pub fn field(
  name: String,
  owner_decoder: fn(Dynamic) -> Result(owner, String),
  params_decoder: fn(Dynamic) -> Result(params, String),
  resolve: fn(owner, params) -> Result(output, String),
) -> Field {
  let dynamic_resolver = fn(owner_data: Dynamic, param_data: Dynamic) -> Result(
    Dynamic,
    String,
  ) {
    use owner <- result.try(owner_decoder(owner_data))
    use params <- result.try(params_decoder(param_data))
    use output <- result.try(resolve(owner, params))

    Ok(dynamic.from(output))
  }

  Field(name: name, resolve: dynamic_resolver)
}

// pub type FieldOutput {
//   FieldOutputScalarBoolean
//   FieldOutputScalarFloat
//   FieldOutputScalarInt
//   FieldOutputScalarString
//   FieldOutputObject(String)
//   FieldOutputNullableObject(String)
//   FieldOutputObjectList(String)
// }

pub type GraphQL {
  GraphQL(objects: List(Object))
}

pub fn execute_request() {
  todo
}

pub fn resolve_object_field(
  object: Object,
  owner_data: Dynamic,
  params_data: Dynamic,
  wanted_field: String,
) -> Result(Dynamic, String) {
  use field <- result.try(
    list.find(object.fields, fn(field) { field.name == wanted_field })
    |> result.replace_error(
      "Unable to resolve field " <> wanted_field <> " in object " <> object.name,
    ),
  )

  field.resolve(owner_data, params_data)
}
