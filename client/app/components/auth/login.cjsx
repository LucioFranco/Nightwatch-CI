React = require 'react/addons'
Router = require 'react-router'

{ RouteHandler } = require 'react-router'

userStoreMixin = require '../../mixins/user_store.coffee'

UserActions = require '../../actions/UserActions.coffee'

Login = React.createClass
  mixins: [ userStoreMixin, React.addons.LinkedStateMixin, Router.Navigation ]

  getInitialState: ->
    username: ''
    password: ''

  getLoginData: ->
    username: @state.username
    password: @state.password

  handleSubmit: (e) ->
    e.preventDefault()

    data = @getLoginData()
    @setState(
      username: ''
      password: ''
    )
    UserActions.login(data)
    @transitionTo '/'


  render: ->
    <div className="login-page row">
      <div className="login col-xs-12 col-xs-offset-0 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
        <form onSubmit={@handleSubmit}>
          <h4 className="login-header text-center">Login</h4>
          <div className="form-group">
            <label htmlFor="loginUsername">Username</label>
            <input type="text" className="form-control" id="loginUsername" valueLink={@linkState('username')} placeholder="Username" />
          </div>
          <div className="form-group">
            <label htmlFor="loginPassword">Password</label>
            <input type="password" className="form-control" id="loginPassword" valueLink={@linkState('password')} placeholder="Password" />
          </div>
          <button type="submit" className="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>

module.exports = Login
