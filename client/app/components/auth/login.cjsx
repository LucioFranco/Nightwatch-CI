React = require 'react'
Reflux = require 'reflux'

{ RouteHandler } = require 'react-router'

UserStore = require '../../stores/UserStore.coffee'
Header = require '../header/header.cjsx'

Login = React.createClass
  mixins: [ Reflux.connect(UserStore) ]
  handleSubmit: (e)->
    e.preventDefault()

  renderLogin: ->
    <div className="login-page row">
      <div className="login col-xs-12 col-xs-offset-0 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
        <form onSubmit={@handleSubmit}>
          <h4 className="login-header text-center">Login</h4>
          <div className="form-group">
            <label htmlFor="loginUsername">Username</label>
            <input type="text" className="form-control" id="loginUsername" placeholder="Username" />
          </div>
          <div className="form-group">
            <label htmlFor="loginPassword">Password</label>
            <input type="password" className="form-control" id="loginPassword" placeholder="Password" />
          </div>
          <button type="submit" className="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>

  render: ->
    if @state.username
       <div>
         <Header />
         <div className="RouteHandler container">
           <RouteHandler />
         </div>
       </div>
    else
       @renderLogin()

module.exports = Login
