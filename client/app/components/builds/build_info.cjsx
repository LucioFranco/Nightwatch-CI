React = require 'react'
{ ListGroup, ListGroupItem, Glyphicon, Input } = require 'react-bootstrap'
_ = require 'lodash'

BuildActions = require '../../actions/BuildActions.coffee'

BuildInfo = React.createClass
  getInitialState: ->
    BuildActions
      .getBuild @props.params?.buildNum
      .then (result) =>
        @setState
          loading: false
          output: JSON.parse result.output
      .catch (err) ->
        console.log err
    loading: true
    onlyFailed: false
    output: {}

  renderTestcases: (module) ->
    testcases = []
    _.forIn module.completed, (e, key) ->
      if e.failed > 0
        testcases.push <p className="testcase"><Glyphicon glyph="remove" /> #{key}</p>
        _.each e.assertions, (e) ->
          testcases.push(<p className="assertion">{e.message + ' ' + e.failure}</p>) unless !e.failure
      else if !@state?.onlyFailed
        testcases.push <p className="testcase"><Glyphicon glyph="ok" /> #{key}</p>
    testcases

  renderModule: (module, moduleName) ->
    if module.failures > 0
      <ListGroupItem bsStyle='danger' header={moduleName}>{@renderTestcases(module)}</ListGroupItem>
    else
      <ListGroupItem bsStyle='success' header={moduleName}>{@renderTestcases(module)}</ListGroupItem>

  renderOutput: ->
    modules = []
    _.forIn @state.output.modules, (e, key) =>
      modules.push @renderModule e, key
    modules

  renderBody: ->
    if @state.loading
      <div>
        <br />
        <h4 className="text-center">Loading...</h4>
      </div>
    else
      <div>
        <ListGroup>
          {@renderOutput()}
        </ListGroup>
      </div>

  filterFailures: ->
    @setState onlyFailed: true

  render: ->
    <div>
      <h1 className="text-center">Build #{@props.params?.buildNum}</h1>
      <Input type="radio" label="Show only failed tests" onChange={@filterFailures} />
      {@renderBody()}
    </div>

module.exports = BuildInfo
