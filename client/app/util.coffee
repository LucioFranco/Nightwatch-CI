superagent = require 'superagent'
module.exports =
  baseUrl: window.location.protocol + '//' + window.location.hostname + ':3000'
  auth_header: ->
    'Authorization': window.localStorage.getItem('auth_token')
