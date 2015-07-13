React = require 'react'
{ Input } = require 'react-bootstrap'
moment = require 'moment-precise-range'
_ = require 'lodash'

BuildActions = require '../../actions/BuildActions.coffee'

SuiteList = require './suite_list.cjsx'

BuildInfo = React.createClass
  getInitialState: ->
    BuildActions
      .getBuild @props.params?.buildNum
      .then (result) =>
        @setState
          loading: false
          build: _.omit result, 'output'
          output: JSON.parse result.output
      .catch (err) =>
        console.log err
        @setState err: err
    loading: true
    onlyFailed: false
    output: {}

  renderStats: ->
    <div className="text-center">
      <p>Length: {moment.preciseDiff(@state.build.started_at, @state.build.finished_at, { day:true, hour: true, minute: true, fixed_second: true })}</p>
      <p> Passed: {@state.output.passed} / {@state.output.assertions}</p>
      <Input type="checkbox" label="Show only failed tests" onChange={@filterFailures} />
    </div>

  renderBody: ->
    if @state.err
      <div>
        <br />
        <h4 className="text-center">Build Not Found</h4>
      </div>
    else if @state.loading
      <div>
        <br />
        <h4 className="text-center">Loading...</h4>
      </div>
    else
      <div>
        {@renderStats()}
        <SuiteList modules={@state.output.modules} onlyFailed={@state?.onlyFailed} />
      </div>

  filterFailures: ->
    if @state?.onlyFailed
      @setState onlyFailed: false
    else
      @setState onlyFailed: true

  render: ->
    <div>
      <h1 className="text-center">Build #{@props.params?.buildNum}</h1>
      {@renderBody()}
    </div>

module.exports = BuildInfo
