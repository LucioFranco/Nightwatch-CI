React = require 'react'
Router = require 'react-router'

DefaultRoute = Router.DefaultRoute
Route = Router.Route;
RouteHandler = Router.RouteHandler

App = require './app.cjsx'
Dashboard = require './components/dashboard/dashboard.cjsx'

module.exports = (app) ->
  <Route name="app" path="/" handler={app}>
    <DefaultRoute handler={Dashboard} />
  </Route>
