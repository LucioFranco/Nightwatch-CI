React = require 'react'
{ Link } = require 'react-router'
{ Col, Panel, Glyphicon } = require 'react-bootstrap'
moment = require 'moment-precise-range'
SmartTimeAgo = require 'react-smart-time-ago'
_ = require 'lodash'

BuildActions = require '../../actions/BuildActions.coffee'
QueueActions = require '../../actions/QueueActions.coffee'

BuildPanel = React.createClass
  cancelBuild: ->
    QueueActions.cancel(@props.build.buildNumber)

  renderStats: ->
    if _.has @props.build, 'pass'
        <span className="pull-right text-right">
          <p>Length: {moment.preciseDiff(@props.build.started_at, @props.build.finished_at, { day:true, hour: true, minute: true, fixed_second: true })}</p>
          <p>Passed: {@props.build?.output?.passed} / {@props.build?.output?.assertions}</p>
          <Link to="build" params={buildNum: @props.build?.buildNumber}>Detailed build info</Link>
        </span>
    else
      <span className="pull-right text-right">
        <a onClick={@cancelBuild}>Cancel</a>
      </span>

  renderIcon: ->
    if _.has @props.build, 'inProgress'
      <h4><Glyphicon glyph={if @props.build.inProgress then 'refresh' else 'upload'} />  Build #{@props.build.buildNumber}</h4>
    else if @props.build
      <h4><Glyphicon glyph={if @props.build.pass then 'ok-sign' else 'remove-sign'} />  Build #{@props.build.buildNumber}</h4>

  render: ->
    <Col>
      <Panel>
        {@renderStats()}
        <span>
          {@renderIcon()}
          <SmartTimeAgo value={if _.has @props.build, 'inProgress' then @props.build.started_at else @props.build.finished_at} />
        </span>
      </Panel>
    </Col>

module.exports = BuildPanel
