React = require 'react'
Reflux = require 'reflux'
QueueStore = require '../../stores/QueueStore.coffee'

BuildPanel = require '../common/build.cjsx'

CurrentBuilds = React.createClass
  mixins: [Reflux.connect(QueueStore, 'queueList')]
  renderBuilds: ->
    builds = []
    _.each @state?.queueList, (e) ->
      builds.push <BuildPanel key={e._id} build={e} />
    if builds.length == 0
      builds.push <h4 className="text-center current-build-text">No Current Builds</h4>
    builds

  render: ->
    <div>
      {@renderBuilds()}
    </div>

module.exports = CurrentBuilds
