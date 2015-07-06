Reflux = require 'reflux'
request = require 'superagent'

UserActions = require '../actions/UserActions.coffee'
Util = require '../util.coffee'


UserStore = Reflux.createStore
  listenables: [UserActions]
  getInitialState: ->
    @onAuth()

  onAuth: ->
    request
      .get Util.baseUrl + '/user/auth/check'
      .end (err, res) ->
        @user = res.body
        @trigger @user


module.exports = UserStore
