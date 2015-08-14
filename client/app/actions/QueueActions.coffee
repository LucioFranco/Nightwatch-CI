Reflux = require 'reflux'
request = require 'superagent'
Util = require '../util.coffee'

QueueActions = Reflux.createActions ['getList', 'newBuild']
QueueActions.cancel= Reflux.createAction asyncResult: true

QueueActions.cancel.listenAndPromise (buildId) ->
  new Promise (resolve, reject) ->
    request
      .del Util.baseUrl + '/api/build/' + buildId
      .set 'Content-Type', 'application/json'
      .set Util.auth_header()
      .end (err, res) ->
        reject err unless !err
        resolve()

module.exports = QueueActions
