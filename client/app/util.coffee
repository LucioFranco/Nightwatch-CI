superagent = require 'superagent'
module.exports =
  baseUrl: window.location.origin
  auth_header: ->
    'Authorization': window.localStorage.getItem('auth_token')
  config:
    buildLimit: 300
