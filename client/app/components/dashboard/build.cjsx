React = require 'react'
Reflux = require 'reflux'
BuildStore = require '../../stores/BuildStore.coffee'

BuildPanel = require '../common/build.cjsx'

Build = React.createClass
  mixins: [Reflux.connect(BuildStore, 'buildList')]
  renderBuilds: ->
    builds = []
    _.each _.dropRight(@state?.buildList, @state?.buildList?.length - 5), (e) ->
      builds.push <BuildPanel key={e._id} build={e} />
    builds

  render: ->
    <div>
      {@renderBuilds()}
    </div>

module.exports = Build
