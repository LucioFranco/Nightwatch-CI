Reflux = require 'reflux'

UserStore = require '../stores/UserStore.coffee'

module.exports =
  mixins: [Reflux.connect(UserStore, 'user')]
