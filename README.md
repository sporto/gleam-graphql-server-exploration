# Gleam GraphQL server exploration

This is some exploration on how a GraphQL server for Gleam could be build.

The aim is to have a fully type safe API. Resolvers should have properly typed inputs and outputs (not Dynamic or Dicts).

This would use code generation to create the server.

## Library code

This is the library code, which contains types like `Field` and `Object`. These
types are used to describe a GraphQL schema.

This would also include a way to parse an incoming query / mutation.

## Application code

This is the application code written by the developers, this code defines objects and resolvers using application types.

## Generated code

This is generated from the application code. This would generate two outputs:

## Schema

This describe the GraphQL schema. Used for generating an IDL and instrospection.

## Resolver

Used during runtime to resolve the query.
