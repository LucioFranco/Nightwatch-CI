Reflux = require 'reflux'
request = require 'superagent'

TeamActions = Reflux.createActions ['getList', 'create']
Util = require '../util.coffee'

TeamActions.create.preEmit = (user) ->
  request
    .post Util.baseUrl + '/api/user'
    .set 'Accept': 'application/json'
    .set Util.auth_header()
    .send user
    .end (err, res) ->
      window.location.href = '/admin'

module.exports = TeamActions
