Reflux = require 'reflux'
request = require 'superagent'

QueueActions = require '../actions/QueueActions.coffee'
Util = require '../util.coffee'
io = require('socket.io-client')(window.location.origin)
_ = require 'lodash'

QueueStore = Reflux.createStore
  listenables: [QueueActions]
  init: ->
    @queueList = []
    io.on 'queueStoreUpdate', (data) => @onGetList()
    @onGetList()

  getInitialState: ->
    @queueList

  onGetList: ->
    request
      .get Util.baseUrl + '/api/build/queue'
      .set 'Content-Type', 'application/json'
      .set Util.auth_header()
      .end (err, res) =>
        @queueList = res.body
        @trigger @queueList

  onNewBuild: ->
    request
      .post Util.baseUrl + '/api/build/start'
      .set Util.auth_header()
      .end (err, res) =>
        @onGetList()

module.exports = QueueStore
