React = require 'react'
Fromsy = require 'formsy-react'
_ = require 'lodash'

{ Input, Select } = require 'formsy-react-components'

TeamActions = require '../../actions/TeamActions.coffee'

CreateUser = React.createClass
  getInitialState: ->
    loading: false

  onValidSubmit: (res) ->
    TeamActions.create _.omit res, 'password1'
    @setState loading: true

  render: ->
    if @state.loading
      <div>
        <h4>Create User</h4>
        <img src={require('loading-svg/loading-spin.svg')} alt="Lodaing icon" />
      </div>
    else
      <div>
        <h4>Create User</h4>
        <Formsy.Form onValidSubmit={@onValidSubmit} >
          <fieldset>
            <Input
              name="firstname"
              value=""
              label="First Name"
              type="text"
              placeholder="Enter first name"
              required
            />
            <Input
              name="lastname"
              value=""
              label="Last Name"
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
              name="email"
              value=""
              label="Email"
              type="email"
              placeholder="Enter email"
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
              name="password1"
              value=""
              label="Confirm Password"
              type="password"
              validations="equalsField:password"
              validationErros={{
                  equalsField: 'Passwords must match'
                }}
              placeholder="Re-type password"
              required
            />
            <Select
              name="group"
              value="a"
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
      </div>

module.exports = CreateUser
