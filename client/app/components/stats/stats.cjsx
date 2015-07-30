React = require 'react'
BuildActions = require 'actions/BuildActions'
{ Link } = require 'react-router'
{ Tooltip, OverlayTrigger } = require 'react-bootstrap'
require 'style/stats'

module.exports = React.createClass
  getInitialState: ->
    build_limit: 50
    loading: true

  componentWillMount: ->
    Promise.all [
      BuildActions.getStats.triggerPromise @state.build_limit
      BuildActions.getLastBuildNumber.triggerPromise()
    ]
      .then (result) =>
        @setState
          last_build_number: result[1]
          stats: result[0]
          loading: false

  renderBuildFromTest: (test) ->
    tooltip = (buildNum) ->
      <Tooltip className="tooltip"><strong>build: {buildNum}</strong></Tooltip>
    list = new Array(@state.build_limit);
    _.map list, (e, i) =>
      currentBuildNum = i + (@state.last_build_number - @state.build_limit)
      if test.indexOf(currentBuildNum) > -1
        <div className="build">
          <OverlayTrigger className="build" delayShow={200} placement="top" overlay={tooltip(currentBuildNum)}>
            <Link to="build" params={buildNum: currentBuildNum} query={showFailed: true}>
              <div className="build failed"></div>
            </Link>
          </OverlayTrigger>
        </div>
      else
        <div className="build">
          <OverlayTrigger className="build" delayShow={200} placement="top" overlay={tooltip(currentBuildNum)}>
            <Link to="build" params={buildNum: currentBuildNum} query={showFailed: true}>
              <div className="build success"></div>
            </Link>
          </OverlayTrigger>
        </div>

  renderStats: ->
    _.map @state.stats, (e, key) =>
      [<li className="list-item test"><strong className="title">{key}</strong></li>, <li className="clearfix list-item test">{@renderBuildFromTest(e)}</li>]

  render: ->
    if !@state.loading
      <ul className="stats-list">{@renderStats()}</ul>
    else
      <div className="text-center">Loading...</div>
