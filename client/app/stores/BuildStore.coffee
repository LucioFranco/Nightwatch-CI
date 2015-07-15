Reflux = require 'reflux'
request = require 'superagent'

BuildActions = require '../actions/BuildActions.coffee'
Util = require '../util.coffee'
io = require('socket.io-client')(window.location.origin)
_ = require 'lodash'

BuildStore = Reflux.createStore
  listenables: [BuildActions]
  init: ->
    @buildList = []
    io.on 'buildStoreUpdate', (data) => @onGetList()

  getInitialState: ->
    @onGetList()
    @buildList

  onGetList: ->
    request
      .get Util.baseUrl + '/api/build'
      .query size: Util.config.buildLimit
      .set 'Content-Type', 'application/json'
      .set Util.auth_header()
      .end (err, res) =>
        @buildList = res.body
        @trigger @buildList

module.exports = BuildStore
