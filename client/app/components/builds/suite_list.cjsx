React = require 'react'
{ ListGroup } = require 'react-bootstrap'
_ = require 'lodash'

TestCase = require './test_case.cjsx'

SuiteList = React.createClass

  renderOutput: ->
    modules = []
    _.forIn @props.modules, (e, key) =>
      if e.failures > 0
        modules.push <TestCase bsStyle='danger' header={key} module={e} failed={true}/>
      else if !@props?.onlyFailed
        modules.push <TestCase bsStyle='success' header={key} module={e} failed={false} />
    modules

  render: ->
    <ListGroup>
      {@renderOutput()}
    </ListGroup>

module.exports = SuiteList
