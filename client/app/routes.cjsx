React = require 'react'
{ DefaultRoute, Route, RouteHandler, NotFoundRoute } = require 'react-router'

Login = require './components/auth/login.cjsx'
Dashboard = require './components/dashboard/dashboard.cjsx'
Builds = require './components/builds/builds.cjsx'
Admin = require './components/admin/admin.cjsx'
CreateUser = require './components/admin/create_user.cjsx'
GenKey = require './components/admin/generate_api_key.cjsx'
Team = require './components/team/team.cjsx'
Stats = require './components/stats/stats.cjsx'
BuildInfo = require './components/builds/build_info.cjsx'
NotFound = require './components/common/not_found.cjsx'

module.exports = (app) ->
    <Route name="app" path="/" handler={app}>
      <DefaultRoute handler={Dashboard} />
      <Route name="login" handler={Login} />
      <Route name="builds" handler={Builds} />
      <Route name="build" path="build/:buildNum" handler={BuildInfo} />
      <Route name="team" handler={Team} />
      <Route name="stats" handler={Stats} />
      <Route name="admin" handler={Admin}>
        <Route name="create" handler={CreateUser} />
        <Route name="genkey" handler={GenKey} />
      </Route>
      <NotFoundRoute handle={NotFound} />
    </Route>
