React = require 'react'
Router = require 'react-router'
Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler
App = require '../../app.cjsx'

Admin = React.createClass
  mixins: [Router.Navigation]
  render: ->
    <div>
      <h4>Admin Page</h4>
      <RouteHandler />
      <Router.Link to='/admin/create'>Create User</Router.Link>
    </div>

module.exports = Admin
