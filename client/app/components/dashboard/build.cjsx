React = require 'react'
Reflux = require 'reflux'
BuildStore = require '../../stores/BuildStore.coffee'

BuildPanel = require '../common/build.cjsx'

Build = React.createClass
  mixins: [Reflux.connect(BuildStore, 'buildList')]
  renderBuilds: ->
    _.chain @state?.buildList
      .take 5
      .map (e) ->
        <BuildPanel key={e._id} build={e} />
      .value()

  render: ->
    <div>
      {@renderBuilds()}
    </div>

module.exports = Build
