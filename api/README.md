# MyAPI

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Required

  * PostgreSQL 10 (Config the DB Connection in "api/config/.exs") (https://www.postgresql.org/)


Inside the REPL `mix phx.server` run the following DB calls to insert users in the DB for auth testing.

MyAPI.Auth.create_user(%{email: "john@imbrex.io", password: "test_password", first_name: "John", last_name: "O'Sullivan", uuid: UUID.uuid4() })

MyAPI.Auth.create_user(%{email: "john+123@imbrex.io", password: "test_password", first_name: "Jimmy", last_name: "O'Sullivan", uuid: UUID.uuid4() })

MyAPI.Auth.create_user(%{email: "james@imbrex.io", password: "test_password", first_name: "James", last_name: "O'Sullivan", uuid: UUID.uuid4() })
