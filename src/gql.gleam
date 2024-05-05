import gleam/io
import lib

pub type User {
  User(name: String, age: Int, friends: List(User), address: Option(Address))
}

pub type Address {
  Address(street_name: String, street_number: String)
}

/// RESOLVER
pub fn resolve_user_address(user: User, _params: Nil) -> Option(Address) {
  user.address
}

pub fn resolve__user__age(user: User, _params: Nil) -> Int {
  user.age
}

pub fn resolve__user__name(user: User, _params: Nil) -> String {
  user.name
}

pub type UserFriendsParams {
  UserFriendsParams(limit: Int)
}

fn decode_friends_params(params: Dynamic) -> Result(UserFriendsParams, String) {
  todo
}

pub fn resolve__user__friends(
  user: User,
  params: UserFriendsParams,
) -> List(User) {
  user.friends
  |> list.take(params.limit)
}

fn null_params_decoder(data: Dynamic) -> Result(Nil, String) {
  Ok(Nil)
}

pub fn resolve__query__current_user(_root: Nil, _params: Nil) -> Option(User) {
  let address = Address(street_name: "Elm Street", street_number: "123")
  let user = User(name: "Sam", age: 18, friends: [], address: Some(address))
  Some(user)
}

pub fn build_schema() {
  let objects = [
    object(name: "Query", fields: [
      field(
        name: "currentUser",
        params_decoder: null_params_decoder,
        resolver: resolve__query__current_user,
      ),
    ]),
    object(name: "User", fields: [
      field(
        name: "age",
        params_decoder: null_params_decoder,
        resolver: resolve__user__age,
      ),
      field(
        name: "name",
        params_decoder: null_params_decoder,
        resolver: resolve__user__name,
      ),
      field(
        name: "friends",
        params_decoder: decode_friends_params,
        resolver: resolve__user__friends,
      ),
    ]),
  ]
}

pub fn main() {
  let schema = build_schema()

  io.println("Hello from gql!")
}
