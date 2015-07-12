request = require 'supertest-as-promised'
whenPro = require 'when'
promisfy = request(whenPro.Promise)
app = require '../index.js'
should = require 'should'

UserFactory = require './factories/userFactory'

config =
  log_level: 'warn'
  noCompile: true
  createAdmin: true

http = request app.init config

describe 'NIGHTWATCH CI API', ->
  user = UserFactory.build 'user', admin: true
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

  it 'CREATE ADMIN', ->
    http
      .post '/auth/login'
      .send user
      .then (res) ->
        res.body.should.be.ok
        console.log res.body
