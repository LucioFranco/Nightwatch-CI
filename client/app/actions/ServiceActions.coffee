Reflux = require 'reflux'
request = require 'superagent'
Util = require '../util.coffee'

genKey = Reflux.createAction asyncResult: true
genKey.listenAndPromise (name) ->
  new Promise (resolve, reject) ->
    request
      .post Util.baseUrl + '/api/service/key'
      .set 'Content-Type', 'application/json'
      .set Util.auth_header()
      .send name: name
      .end (err, res) ->
        reject err if err
        resolve res.body

module.exports =
  genKey: genKey
