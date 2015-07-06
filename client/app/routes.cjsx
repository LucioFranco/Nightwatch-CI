React = require 'react'
{ DefaultRoute, Route, RouteHandler } = require 'react-router'

Login = require './components/auth/login.cjsx'
Dashboard = require './components/dashboard/dashboard.cjsx'
Builds = require './components/builds/builds.cjsx'
Admin = require './components/admin/admin.cjsx'
CreateUser = require './components/admin/create_user.cjsx'

module.exports = (app) ->
    <Route name="app" path="/" handler={app}>
      <Route path="/?" handler={Login}>
        <DefaultRoute handler={Dashboard} />
        <Route name="builds" handler={Builds} />
        <Route name="admin" handler={Admin}>
          <Route name="create" handler={CreateUser} />
        </Route>
      </Route>
    </Route>
