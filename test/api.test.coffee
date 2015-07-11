request = require 'supertest-as-promised'
whenPro = require 'when'
promisfy = request(whenPro.Promise)
app = require '../index.js'

config =
  test: true
  noCompile: true

http = request app.init config

describe '', ->
  it '', ->
    http
      .get '/auth/check'
      .expect 401
  it '', ->
    http
      .get '/api/builds'
      .then (res) ->
        console.log res
