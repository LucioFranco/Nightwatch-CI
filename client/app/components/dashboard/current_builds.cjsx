React = require 'react'
Reflux = require 'reflux'
BuildStore = require '../../stores/BuildStore.coffee'

BuildPanel = require '../common/build.cjsx'

CurrentBuilds = React.createClass
  mixins: [Reflux.connect(BuildStore, 'buildList')]
  renderBuilds: ->
    builds = []
    _.eachRight _.filter(@state?.buildList, (n) -> n.inProgress), (e) ->
      builds.push <BuildPanel key={e._id} build={e} />
    if builds.length == 0
      builds.push <h4>No Current Builds</h4>
    builds

  render: ->
    <div>
      {@renderBuilds()}
    </div>

module.exports = CurrentBuilds
