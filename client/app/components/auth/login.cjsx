React = require 'react/addons'

{ RouteHandler } = require 'react-router'

userStoreMixin = require '../../mixins/user_store.coffee'

UserActions = require '../../actions/UserActions.coffee'
Header = require '../header/header.cjsx'

Login = React.createClass
  mixins: [ userStoreMixin, React.addons.LinkedStateMixin ]

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


  renderLogin: ->
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

  renderLayout: ->
    <div>
      <Header />
      <div className="RouteHandler container">
        <RouteHandler />
      </div>
    </div>

  render: ->
    console.log @state.user
    if @state.user?.username
      @renderLayout()
    else
      @renderLogin()

module.exports = Login
