React = require 'react'
Reflux = require 'reflux'
QueueStore = require '../../stores/QueueStore.coffee'

BuildPanel = require '../common/build.cjsx'

CurrentBuilds = React.createClass
  mixins: [Reflux.connect(QueueStore, 'queueList')]
  renderBuilds: ->
    if @state?.queueList.length == 0
      <h4 className="text-center panel-body-text">No Current Builds</h4>
    else
      _.map @state?.queueList, (e) ->
        <BuildPanel key={e._id} build={e} />

  render: ->
    <div>
      {@renderBuilds()}
    </div>

module.exports = CurrentBuilds
