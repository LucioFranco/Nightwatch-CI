React = require 'react'
{ ListGroupItem, Glyphicon } = require 'react-bootstrap'
_ = require 'lodash'

SuiteList = React.createClass
  getInitialState: ->
    showTestCases: false

  showTestCases: ->
    if @state.showTestCases
      @setState showTestCases: false
    else
      @setState showTestCases: true

  renderTestCases: ->
    testcases = []
    _.forIn @props.module.completed, (e, key) =>
      if e.failed > 0
        testcases.push <p className="testcase"><Glyphicon glyph="remove" /> #{key}</p>
        _.each e.assertions, (e) ->
          testcases.push(<p className="assertion">{e.message + ' ' + e.failure}</p>) unless !e.failure
          testcases.push(<p className="stacktrace">{e.stacktrace}</p>) unless e.stacktrace == ''
      else
        testcases.push <p className="testcase"><Glyphicon glyph="ok" /> #{key}</p>
    testcases

  render: ->
    <ListGroupItem className="module-list-item" bsStyle={@props.bsStyle} header={@props.header} onClick={@showTestCases}>
      <p className="assertion-stat">{if @props.failed then @props.module.failures + ' assertions failed' else @props.module.tests + ' assertions passed' }</p>
      <div>{@renderTestCases() unless !@state.showTestCases}</div>
    </ListGroupItem>

module.exports = SuiteList
