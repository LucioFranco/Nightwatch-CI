React = require 'react'
Router = require 'react-router'
Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler

Admin = React.createClass
  mixins: [Router.Navigation]
  render: ->
    <div>
      <h4>Admin Page</h4>
      <Router.Link to='/admin/create'>Create User</Router.Link>
      <br />
      <Router.Link to='/admin/genkey'>Generate API Key</Router.Link>
    </div>

module.exports = Admin
