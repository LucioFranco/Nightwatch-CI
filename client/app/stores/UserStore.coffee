Reflux = require 'reflux'
request = require 'superagent'

UserActions = require '../actions/UserActions.coffee'
Util = require '../util.coffee'


UserStore = Reflux.createStore
  listenables: [UserActions]
  user: { }
  getInitialState: ->

  onGetUser: ->
    user

  onCreateUser: (user) ->
    console.log 'asdfasdf'
    request
      .post Util.baseUrl + '/user'
      .set 'Content-Type', 'application/json'
      .send user
      .end (err, result) ->
        console.log result


module.exports = UserStore
