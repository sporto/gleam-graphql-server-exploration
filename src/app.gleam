// This contains app specific code
// Used to generate the rest

import gleam/option.{type Option, None, Some}

pub type Query {
  Query(current_user: Option(User))
}

pub fn resolve_query_user(_root: #(), _params: #()) -> Result(User, String) {
  let address = Address(street_name: "Elm Street", street_number: "123")
  let user = User(name: "Sam", age: 18, friends: [], address: Some(address))
  Ok(user)
}

pub type User {
  User(name: String, age: Int, friends: List(User), address: Option(Address))
}

pub type Address {
  Address(street_name: String, street_number: String)
}

pub type UserAddressParams {
  UserAddressParams
}

// We need some kind of type annotation to indicate that this will generate code
// We should get the resulting object type from the return signature
pub fn resolve_user_address(
  user: User,
  _params: UserAddressParams,
) -> Option(Address) {
  user.address
}

// params empty tuple indicates no params
// use always has a name
pub fn resolve_user_name(user: User, _params: #()) -> String {
  user.name
}
