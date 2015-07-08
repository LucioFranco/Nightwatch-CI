Reflux = require 'reflux'
request = require 'superagent'
_ = require 'lodash'

UserActions = require '../actions/UserActions.coffee'
Util = require '../util.coffee'

UserStore = Reflux.createStore
  listenables: [ UserActions ]
  init: ->
    @user = {}

  getInitialState: ->
    @onAuth()
    @user

  onLogout: ->
    window.localStorage.removeItem 'auth_token'
    window.location.href = '/'

  onLogin: (data)->
    request
      .post Util.baseUrl + '/auth/login'
      .set 'Accept': 'application/json'
      .send data
      .end (err, res) =>
        window.localStorage.setItem 'auth_token', 'JWT ' + res.body?.auth_token
        @user = _.omit res.body, 'auth_token'
        @trigger @user

  onAuth: ->
    request
      .get Util.baseUrl + '/auth/check'
      .set Util.auth_header()
      .end (err, res) =>
        @user = res.body
        @trigger @user

module.exports = UserStore
