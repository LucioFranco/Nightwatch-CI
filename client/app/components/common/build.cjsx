React = require 'react'
Col = require 'react-bootstrap/lib/Col'
Panel = require 'react-bootstrap/lib/Panel'
Glyph = require 'react-bootstrap/lib/Glyphicon'
ModalTrigger = require 'react-bootstrap/lib/ModalTrigger'
Modal = require 'react-bootstrap/lib/Modal'
SmartTimeAgo = require 'react-smart-time-ago'

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
  render: ->
    <Col>
      <Panel>
        <ModalTrigger modal={<BuildModal {...@props} />}>
          <span>
            <h4>
              <Glyph glyph={if @props.build.inProgress then 'refresh' else if @props.build.pass then 'ok-sign' else 'remove-sign'} />  Build #{@props.build.buildNumber}
            </h4>
            <SmartTimeAgo value={@props.build.timestamp} />
          </span>
        </ModalTrigger>
      </Panel>
    </Col>

module.exports = BuildPanel
