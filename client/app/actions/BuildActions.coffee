Reflux = require 'reflux'
request = require 'superagent'
Util = require '../util.coffee'

BuildActions = Reflux.createActions ['getList']
BuildActions.getBuild = Reflux.createAction asyncResult: true

BuildActions.getBuild.listenAndPromise (buildNum) ->
  new Promise (resolve, reject) ->
    request
      .get Util.baseUrl + '/api/build/' + buildNum
      .set 'Content-Type', 'application/json'
      .set Util.auth_header()
      .end (err, res) ->
        console.log JSON.parse res.body.output
        reject err if err
        resolve res.body

module.exports = BuildActions
