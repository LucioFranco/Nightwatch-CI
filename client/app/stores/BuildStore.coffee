Reflux = require 'reflux'
request = require 'superagent'

BuildActions = require '../actions/BuildActions.coffee'

BuildStore = Reflux.createStore
  listenables: [BuildActions]
  buildList: []
  getInitialState: ->
    @onGetList()

  onGetList: ->
    request
      .get 'http://localhost:3000/api/build'
      .set 'Content-Type', 'application/json'
      .end (err, res) =>
        @buildList = res.body
        @trigger @buildList

  onNewBuild: ->
    @buildList.push({ pass: true, inProgress: true, number: @buildList.length + 1 });
    @trigger @buildList
    request
      .get 'http://localhost:3000/api/build/start'
      .end (err, res) =>
        @onGetList()

module.exports = BuildStore
