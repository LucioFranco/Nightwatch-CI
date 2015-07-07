React = require 'react/addons'
Router = require 'react-router'
Fromsy = require 'formsy-react'

{ RouteHandler } = require 'react-router'
{ Modal } = require 'react-bootstrap'
{ Input } = require 'formsy-react-components'

userStoreMixin = require '../../mixins/user_store.coffee'

UserActions = require '../../actions/UserActions.coffee'

Login = React.createClass
  #mixins: [ userStoreMixin, React.addons.LinkedStateMixin, Router.Navigation ]

  handleSubmit: (res) ->
    UserActions.login(res)


  render: ->
    <Modal
      onRequestHide={=>}
    >
        <Formsy.Form onValidSubmit={@handleSubmit} >
          <fieldset>
            <Input
              name="username"
              value=""
              label="Username"
              type="text"
              placeholder="Enter username"
              required
            />
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
