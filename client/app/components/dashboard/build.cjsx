React = require 'react'
Col = require 'react-bootstrap/lib/Col'
Panel = require 'react-bootstrap/lib/Panel'
Glyph = require 'react-bootstrap/lib/Glyphicon'
ModalTrigger = require 'react-bootstrap/lib/ModalTrigger'
Modal = require 'react-bootstrap/lib/Modal'

BuildModal = React.createClass
  render: ->
    <Modal {...@props} title={"Build " + @props.build.number}>
      <div className="modal-body">
        <p>
          {@props.build.output}
        </p>
      </div>
    </Modal>

Build = React.createClass
  render: ->
    <Col>
      <Panel>
        <ModalTrigger modal={<BuildModal {...@props} />}>
          <h4><Glyph glyph={if @props.build.inProgress then 'refresh' else if @props.build.pass then 'ok-sign' else 'remove-sign'} />  Build {@props.build.number}</h4>
        </ModalTrigger>
      </Panel>
    </Col>

module.exports = Build
