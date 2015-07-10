React = require 'react'
{ DefaultRoute, Route, RouteHandler } = require 'react-router'

Login = require './components/auth/login.cjsx'
Dashboard = require './components/dashboard/dashboard.cjsx'
Builds = require './components/builds/builds.cjsx'
Admin = require './components/admin/admin.cjsx'
CreateUser = require './components/admin/create_user.cjsx'
GenKey = require './components/admin/generate_api_key.cjsx'
Team = require './components/team/team.cjsx'
BuildInfo = require './components/builds/build_info.cjsx'

module.exports = (app) ->
    <Route name="app" path="/" handler={app}>
      <DefaultRoute handler={Dashboard} />
      <Route name="login" handler={Login} />
      <Route name="builds" handler={Builds} />
      <Route name="build" path="build/:buildNum" handler={BuildInfo} />
      <Route name="team" handler={Team} />
      <Route name="admin" handler={Admin}>
        <Route name="create" handler={CreateUser} />
        <Route name="genkey" handler={GenKey} />
      </Route>
    </Route>
