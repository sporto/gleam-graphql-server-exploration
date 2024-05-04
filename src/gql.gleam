import generated
import gleam/io

pub fn main() {
  let graphql = generated.build_graphql()

  io.println("Hello from gql!")
}
