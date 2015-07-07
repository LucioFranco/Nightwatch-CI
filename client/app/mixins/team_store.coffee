Reflux = require 'reflux'

TeamStore = require '../stores/TeamStore.coffee'

module.exports =
  mixins: [Reflux.connect(TeamStore, 'team')]
