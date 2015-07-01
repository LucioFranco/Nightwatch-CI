React = require 'react'
Col = require 'react-bootstrap/lib/Col'
Panel = require 'react-bootstrap/lib/Panel'
Glyph = require 'react-bootstrap/lib/Glyphicon'
ModalTrigger = require 'react-bootstrap/lib/ModalTrigger'
Modal = require 'react-bootstrap/lib/Modal'
SmartTimeAgo = require 'react-smart-time-ago'
_ = require 'lodash'

BuildModal = React.createClass
  render: ->
    <Modal {...@props} title={"Build #" + @props.build.buildNumber}>
      <div className="modal-body">
        <p>
          {@props.build.output}
        </p>
      </div>
    </Modal>

BuildPanel = React.createClass
  renderStats: ->
    if _.has @props.build, 'pass'
        <span className="pull-right"><p>Passed: {@props.build?.output?.passed} / {@props.build?.output?.assertions}</p></span>

  renderIcon: ->
    if _.has @props.build, 'inProgress'
      <h4><Glyph glyph={if @props.build.inProgress then 'refresh' else 'upload'} />  Build #{@props.build.buildNumber}</h4>
    else if @props.build
      <h4><Glyph glyph={if @props.build.pass then 'ok-sign' else 'remove-sign'} />  Build #{@props.build.buildNumber}</h4>

  render: ->
    <Col>
      <ModalTrigger modal={<BuildModal {...@props} />}>
        <Panel>
          <span>
            {@renderIcon()}
            <SmartTimeAgo value={@props.build.timestamp} />
          </span>
          {@renderStats()}
        </Panel>
      </ModalTrigger>
    </Col>

module.exports = BuildPanel
