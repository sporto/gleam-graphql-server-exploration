// This contains app specific code
// Used to generate the rest

pub type User {
  User(name: String, age: Int, friends: List(User), address: Address)
}

pub type Address {
  Address(street_name: String, street_number: String)
}

pub type UserAddressParams {
  UserAddressParams
}

pub fn resolve_query_user(root: #(), params: #()) -> Result(User, String) {
  let address = Address(street_name: "Elm Street", street_number: "123")
  let user = User(name: "Sam", age: 18, friends: [], address: address)
  Ok(user)
}

// We need some kind of type annotation to indicate that this will generate code
// We should get the resulting object type from the return signature
pub fn resolve_user_address(
  user: User,
  params: UserAddressParams,
) -> Result(Address, String) {
  Ok(user.address)
}

// params empty tuple indicates no params
pub fn resolve_user_name(user: User, params: #()) -> Result(String, String) {
  Ok(user.name)
}
