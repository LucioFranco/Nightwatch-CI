request = require 'supertest-as-promised'
whenPro = require 'when'
promisfy = request(whenPro.Promise)
app = require '../index.js'
should = require 'should'

config =
  noCompile: true

http = request app.init config

describe 'NIGHTWATCH CI API', ->
  it 'AUTH CHECK SHOULD 401', ->
    http
      .get '/auth/check'
      .expect 401

  it 'GET BUILDS', ->
    http
      .get '/api/build'
      .expect 200
      .then (res) ->
        res.body.should.be.ok
