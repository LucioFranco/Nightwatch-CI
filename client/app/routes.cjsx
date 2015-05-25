React = require 'react'
Router = require 'react-router'

DefaultRoute = Router.DefaultRoute
Route = Router.Route;
RouteHandler = Router.RouteHandler

Dashboard = require './components/dashboard/dashboard.cjsx'
Builds = require './components/builds/builds.cjsx'

module.exports = (app) ->
  <Route name="app" path="/" handler={app}>
    <DefaultRoute handler={Dashboard} />
    <Route name="builds" handler={Builds} />
  </Route>
