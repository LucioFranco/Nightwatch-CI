React = require 'react'
Reflux = require 'reflux'

BuildStore = require '../../stores/BuildStore.coffee'
BuildPanel = require '../common/build.cjsx'

Builds = React.createClass
  mixins: [Reflux.connect(BuildStore, 'buildList')]

  renderBuilds: ->
    builds = []
    _.eachRight @state?.buildList, (e) ->
      builds.push <BuildPanel build={e} />
    builds

  render: ->
    <div className="container">
      <h1 className="text-center">Builds</h1>
      {@renderBuilds()}
    </div>

module.exports = Builds
