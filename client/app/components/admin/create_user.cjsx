React = require 'react'
Fromsy = require 'formsy-react'
{ Input, Select } = require 'formsy-react-components'

UserActions = require '../../actions/UserActions.coffee'

CreateUser = React.createClass
  onValidSubmit: (res)->
    UserActions.createUser(res)

  render: ->
    <h4>Create User</h4>
    <Formsy.Form onValidSubmit={@onValidSubmit} >
      <fieldset>
        <Input
          name="firstname"
          value=""
          label="FirstName"
          type="text"
          placeholder="Enter first name"
          required
        />
        <Input
          name="lastname"
          value=""
          label="LastName"
          type="text"
          placeholder="Enter last name"
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
          required
        />
        <Select
          name="Group"
          value="Admin"
          label="Group"
          options={[ {value: 'a', label: 'admin'}, {value: 'u', label: 'user'} ]}
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

module.exports = CreateUser
