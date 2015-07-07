Reflux = require 'reflux'
request = require 'superagent'
_ = require 'lodash'

TeamActions = require '../actions/TeamActions.coffee'
Util = require '../util.coffee'


TeamStore = Reflux.createStore
  listenables: [ TeamActions ]
  init: ->
    @users = []

  getInitialState: ->
    @onGetList()
    @users

  onGetList: ->
    request
      .get Util.baseUrl + '/api/user'
      .set 'Accept': 'application/json'
      .set Util.auth_header()
      .end (err, res) =>
        @users = res.body
        @trigger @users

  onCreate: ->
    @onGetList()


module.exports = TeamStore
