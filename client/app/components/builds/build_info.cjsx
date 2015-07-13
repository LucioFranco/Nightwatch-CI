React = require 'react'
{ Input } = require 'react-bootstrap'
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
          output: JSON.parse result.output
      .catch (err) =>
        console.log err
        @setState err: err
    loading: true
    onlyFailed: false
    output: {}

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
        <Input className="text-center" type="checkbox" label="Show only failed tests" onChange={@filterFailures} />
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
