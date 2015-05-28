React = require 'react'
Fromsy = require 'formsy-react'
FRC = require 'formsy-react-components'
Input = FRC.Input

UserActions = require '../../actions/UserActions.coffee'

CreateUser = React.createClass
  onValidSubmit: (res)->
    UserActions.createUser()

  render: ->
    <h4>Create User</h4>
    <Formsy.Form onValidSubmit={@onValidSubmit} >
      <fieldset>
        <Input
          name="name"
          value=""
          label="Name"
          type="text"
          placeholder="Enter name"
          required
        />
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
        <Input
          name="email"
          value=""
          label="Email"
          type="email"
          placeholder="Enter email"
        />
        <input
          className="btn btn-primary"
          formNoValidate={true}
          type="submit"
          defaultValue="Submit"
        />
      </fieldset>
    </Formsy.Form>

module.exports = CreateUser
