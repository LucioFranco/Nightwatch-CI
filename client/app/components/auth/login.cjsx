React = require 'react/addons'
Fromsy = require 'formsy-react'

#style imports
require './login.less'

{ Modal } = require 'react-bootstrap'
{ Input } = require 'formsy-react-components'

UserActions = require '../../actions/UserActions.coffee'

Login = React.createClass
  handleSubmit: (res) ->
    UserActions.login res

  render: ->
    <Modal onRequestHide={@props.onClose}>
        <Formsy.Form onValidSubmit={@handleSubmit} className="login-form" >
          <fieldset>
            <Input
              name="username"
              value=""
              label="Username"
              type="text"
              placeholder="Enter username"
              required
            />
            <br />
            <Input
              name="password"
              value=""
              label="Password"
              type="password"
              placeholder="Enter password"
              required
            />
            <input
              className="btn btn-primary"
              formNoValidate={true}
              type="submit"
              defaultValue="Submit"
            />
          </fieldset>
        </Formsy.Form>
    </Modal>

module.exports = Login
