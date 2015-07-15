React = require 'react'
Reflux = require 'reflux'
Util = require '../../util.coffee'

BuildStore = require '../../stores/BuildStore.coffee'
BuildPanel = require '../common/build.cjsx'

Builds = React.createClass
  mixins: [Reflux.connect(BuildStore, 'builds')]

  renderBuilds: ->
    _.chain @state?.builds
      .take if @props.query?.size then parseInt(@props.query?.size) + 1 else Util.config.buildLimit
      .map (e) ->
        <BuildPanel key={e._id} build={e} />
      .value()

  render: ->
    <div className="container">
      <h1 className="text-center">Builds</h1>
      {@renderBuilds()}
    </div>

module.exports = Builds
