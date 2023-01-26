# README

This Rails app has been intentionally designed in a way that there are areas for improvement.

It's your mission to find this places and refactor them.

## Requirements to run this app

* Ruby version: `3.2.0`
* Database: `sqlite3`

## How to setup this app
```sh
bin/setup
```

## Useful commands

* `bin/rails test` - it will run the test suite.
* `bin/rails rubycritic` - it will generate a quality report of this codebase.

## Examples of cURL requests to interact with the API

First, run the application:

```sh
bin/rails s
```

Then, use some of the following commands to interact with the API resources:

### Creating a token
```sh
curl -X GET "http://localhost:3000/get_token" \
  -H "Content-Type: application/json"
```

### Calculate imc
```sh
curl -X POST "http://localhost:3000/imc" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SOME-USER-TOKEN" \
  -d '{"imc": { "height": 1.70, "weight": 76}}'
```
