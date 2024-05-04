// This contains app specific code
// Used to generate the rest

import gleam/option.{type Option, None, Some}

// TODO
// - Define a way to declare graphql fields on an object
// - A Graphql Object could be simply a dict in Gleam too
// - Define a way to declare the resolvers to use for each field

pub type Query {
  Query(current_user: Option(User))
}

pub fn resolve__query__current_user(_root: #(), _params: #()) -> Option(User) {
  let address = Address(street_name: "Elm Street", street_number: "123")
  let user = User(name: "Sam", age: 18, friends: [], address: Some(address))
  Some(user)
}

// How do you define what fields are exposed in graphql?
// Maybe you need to define specific types for Graphql
pub type User {
  User(name: String, age: Int, friends: List(User), address: Option(Address))
}

pub type Address {
  Address(street_name: String, street_number: String)
}

// We need some kind of type annotation to indicate that this will generate code
// We should get the resulting object type from the return signature
/// object: User
/// field: address
pub fn resolve_user_address(
  user: User,
  _params: UserAddressParams,
) -> Option(Address) {
  user.address
}

/// object: User
/// field: name
pub fn resolve_user_name(user: User, _params: #()) -> String {
  user.name
}

// Optional params?
// Default params?
pub type UserFriendsParams {
  UserFriendsParams(limit: Int)
}

/// object: User
/// field: friends
pub fn resolve_user_friends(user: User, params: UserFriendsParams) -> List(User) {
  user.friends
  |> list.take(params.limit)
}
