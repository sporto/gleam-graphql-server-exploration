import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}
import gleam/io
import gleam/result

// type Scalar {
//   ScalarBoolean
//   ScalarFloat
//   ScalarInt
//   ScalarString
//   ScalarID
// }

// Maybe use has to wrap all possible objects
type User {
  User(name: String, age: Int, friends: List(User), address: Address)
}

type Address {
  Address(street_name: String, street_number: String)
}

type UserAddressParams {
  UserAddressParams
}

fn resolve_query_user(root: #(), params: #()) -> Result(User, String) {
  let address = Address(street_name: "Elm Street", street_number: "123")
  let user = User(name: "Sam", age: 18, friends: [], address: address)
  Ok(user)
}

// We need some kind of type annotation to indicate that this will generate code
// We should get the resulting object type from the return signature
fn resolve_user_address(
  user: User,
  params: UserAddressParams,
) -> Result(Address, String) {
  Ok(user.address)
}

// params empty tuple indicates no params
fn resolve_user_name(user: User, params: #()) -> Result(String, String) {
  Ok(user.name)
}

// THIS IS GENERATED
fn decode_user(data: Dynamic) -> Result(User, String) {
  todo
}

fn decode_params_user_address(
  data: Dynamic,
) -> Result(UserAddressParams, String) {
  todo
}

fn decode_params_user_name(data: Dynamic) -> Result(#(), String) {
  Ok(#())
}

fn decode_query(data: Dynamic) -> Result(#(), String) {
  Ok(#())
}

fn decode_params_query_user(data: Dynamic) -> Result(#(), String) {
  Ok(#())
}

fn encode_user(user: User) -> Dynamic {
  todo
}

fn encode_user_address(address: Address) -> Dynamic {
  todo
}

fn encode_user_name(name: String) -> Dynamic {
  todo
}

// This is generated
fn resolve(
  path: String,
  owner: Dynamic,
  params_dict: Dynamic,
) -> Result(Dynamic, String) {
  case path {
    "User.address" -> {
      use user <- result.try(decode_user(owner))
      use params <- result.try(decode_params_user_address(params_dict))
      use address <- result.try(resolve_user_address(user, params))

      Ok(encode_user_address(address))
    }
    "User.name" -> {
      use user <- result.try(decode_user(owner))
      use params <- result.try(decode_params_user_name(params_dict))
      use name <- result.try(resolve_user_name(user, params))

      Ok(encode_user_name(name))
    }
    "Query.user" -> {
      use owner <- result.try(decode_query(owner))
      use params <- result.try(decode_params_query_user(params_dict))
      use user <- result.try(resolve_query_user(owner, params))

      Ok(encode_user(user))
    }
    _ -> {
      Error("Couldn't resolve object" <> path)
    }
  }
}

// Types for representing the schema
type Object {
  Object(name: String, fields: List(Field))
}

// Output of a field can be an object or a scalar
type Field {
  Field(name: String, args: Dict(String, String), output: String)
}

type Schema {
  Schema(objects: List(Object), query: Object)
}

type ResolveFn =
  fn(String, Dynamic, Dynamic) -> Result(Dynamic, String)

type GraphQL {
  GraphQL(schema: Schema, resolve: ResolveFn)
}

fn build_schema() -> Schema {
  let objects = [
    Object(name: "User", fields: [
      Field("name", args: dict.new(), output: "SCALAR_STRING"),
      Field("age", args: dict.new(), output: "SCALAR_INT"),
      Field("friends", args: dict.new(), output: "LIST User"),
      Field("address", args: dict.new(), output: "Address"),
    ]),
    Object(name: "Address", fields: [
      Field("streetName", args: dict.new(), output: "SCALAR_STRING"),
      Field("streetNumber", args: dict.new(), output: "SCALAR_STRING"),
    ]),
  ]

  let query_obj =
    Object(name: "Query", fields: [
      Field(name: "user", args: dict.new(), output: "User"),
    ])

  Schema(objects: objects, query: query_obj)
}

fn build_graphql() -> GraphQL {
  let schema = build_schema()
  GraphQL(schema: schema, resolve: resolve)
}

pub fn main() {
  let graphql = build_graphql()

  io.println("Hello from gql!")
}
