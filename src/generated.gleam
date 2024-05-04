// This contains generated code
import app.{type Address, type User, type UserAddressParams}
import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}
import gleam/result
import lib.{type GraphQL, type Schema, Field, GraphQL, Object, Schema}

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
      use address <- result.try(app.resolve_user_address(user, params))

      Ok(encode_user_address(address))
    }
    "User.name" -> {
      use user <- result.try(decode_user(owner))
      use params <- result.try(decode_params_user_name(params_dict))
      use name <- result.try(app.resolve_user_name(user, params))

      Ok(encode_user_name(name))
    }
    "Query.user" -> {
      use owner <- result.try(decode_query(owner))
      use params <- result.try(decode_params_query_user(params_dict))
      use user <- result.try(app.resolve_query_user(owner, params))

      Ok(encode_user(user))
    }
    _ -> {
      Error("Couldn't resolve object" <> path)
    }
  }
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

pub fn build_graphql() -> GraphQL {
  let schema = build_schema()
  GraphQL(schema: schema, resolve: resolve)
}
