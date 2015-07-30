Reflux = require 'reflux'
request = require 'superagent'
Util = require '../util.coffee'

BuildActions = Reflux.createActions ['getList']
BuildActions.getBuild = Reflux.createAction asyncResult: true
BuildActions.getStats = Reflux.createAction asyncResult: true
BuildActions.getLastBuildNumber = Reflux.createAction asyncResult: true

BuildActions.getBuild.listenAndPromise (buildNum) ->
  new Promise (resolve, reject) ->
    request
      .get Util.baseUrl + '/api/build/' + buildNum
      .set 'Content-Type', 'application/json'
      .end (err, res) ->
        reject err if err
        resolve res.body

BuildActions.getStats.listenAndPromise (size) ->
  new Promise (resolve, reject) ->
    request
      .get Util.baseUrl + '/api/build/stats'
      .set 'Content-Type', 'application/json'
      .query size: size
      .end (err, res) ->
        reject err unless !err
        resolve res.body

BuildActions.getLastBuildNumber.listenAndPromise (size) ->
  new Promise (resolve, reject) ->
    request
      .get Util.baseUrl + '/api/build/lastBuildNumber'
      .set 'Content-Type', 'application/json'
      .end (err, res) ->
        reject err unless !err
        resolve res.body?.buildNumber

module.exports = BuildActions
