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
  Field(name: String, args: Dict(String, String), output_name: String)
}

type Query {
  Query(fields: List(Field))
}

type Schema {
  Schema(query: Query)
}

type ResolveFn =
  fn(String, Dynamic, Dynamic) -> Result(Dynamic, String)

type GraphQl {
  GraphQL(schema: Schema, resolve: ResolveFn)
}

pub fn main() {
  let schema =
    Schema(
      query: Query(fields: [
        Field(name: "user", args: dict.new(), out: obj_user),
      ]),
    )

  io.println("Hello from gql!")
}
