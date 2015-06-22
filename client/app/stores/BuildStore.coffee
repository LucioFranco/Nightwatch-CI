Reflux = require 'reflux'
request = require 'superagent'

BuildActions = require '../actions/BuildActions.coffee'
Util = require '../util.coffee'
io = require('socket.io-client')(window.location.origin)

BuildStore = Reflux.createStore
  listenables: [BuildActions]
  buildList: []
  getInitialState: ->
    io.on 'buildStoreUpdate', (data) =>
      console.log 'store update'
      @onGetList()
    @onGetList()

  onGetList: ->
    request
      .get Util.baseUrl + '/api/build'
      .set 'Content-Type', 'application/json'
      .end (err, res) =>
        @buildList = res.body
        @trigger @buildList

  onNewBuild: ->
    @buildList.push({ pass: false, inProgress: true, buildNumber: @buildList.length + 1 });
    @trigger @buildList
    request
      .post Util.baseUrl + '/api/build/start'
      .end (err, res) =>
        @onGetList()

module.exports = BuildStore
