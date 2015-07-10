React = require 'react'
{ ListGroup, ListGroupItem, Glyphicon } = require 'react-bootstrap'
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
    output: {}

  renderTestcases: (module) ->
    testcases = []
    _.forIn module.completed, (e, key) ->
      if e.failed > 0
        testcases.push <p className="testcase"><Glyphicon glyph="remove" /> {key}</p>
        _.each e.assertions, (e) ->
          testcases.push <p className="assertion">{e.message}</p> unless !e.failure
      else
        testcases.push <p className="testcase"><Glyphicon glyph="ok" /> {key}</p>
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

  render: ->
    <div>
      <h1 className="text-center">Build #{@props.params?.buildNum}</h1>
      {@renderBody()}
    </div>

module.exports = BuildInfo
