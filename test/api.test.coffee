request = require('supertest-as-promised')(require('when').Promise)
should = require 'should'
server = require '../bin/test'
_ = require 'lodash'
http = request server()

UserFactory = require './factories/userFactory'
user = UserFactory.build 'user', admin: true

lastbuild = 0


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
        res.body.should.be.Array
        lastbuild = _.last res.body

  it 'CREATE ADMIN', ->
    http
      .post '/auth/create/admin/once'
      .send user
      .expect 302
      .then (res) ->
        res.body.should.be.ok

  it 'LOGIN WITH ADMIN', ->
    http
      .post '/auth/login'
      .send _.pick user, ['username', 'password']
      .expect 200
      .then (res) ->
        res.body.should.be.Object
        res.body.should.have.property 'auth_token'
        user.auth_header = Authorization: 'JWT ' + res.body.auth_token

  it 'AUTH CHECK SHOULD 200', ->
    http
      .get '/auth/check'
      .set user.auth_header
      .expect 200
      .then (res) ->
        res.body.should.be.Object
        _.omit(res.body, ['_id', 'timestamp']).should.containEql _.omit user, ['auth_header', 'password']

  it 'START BUILD', ->
    http
      .post '/api/build/start'
      .set user.auth_header
      .expect 200
      .then (res) ->
        res.body.should.be.ok

  it 'CHECK BUILD', ->
    http
      .get '/api/build/queue'
      .expect 200
      .then (res) ->
        res.body.should.be.Array
        res.body[0].should.have.properties ['buildNumber', 'inProgress']
        res.body[0].inProgress.should.be.true

  it 'ADD NEW BUILD WITH CONFIG', ->
    config =
      args: [ '--group', 'test' ]
    http
      .post '/api/build/start'
      .set user.auth_header
      .send config
      .expect 200
      .then (res) ->
        res.body.should.be.ok

  it 'CHECK NEW BUILD CONFIG', ->
    http
      .get '/api/build/queue'
      .expect 200
      .then (res) ->
        res.body.should.be.Array
        res.body.length.should.eql 2
        res.body[0].inProgress.should.be.true
        res.body[1].inProgress.should.be.true
