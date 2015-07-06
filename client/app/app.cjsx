React = require 'react'
Router = require 'react-router'

require './app.less'

RouteHandler = Router.RouteHandler

App = React.createClass
  mixins: [ Router.State ]
  render: ->
      <RouteHandler />
Router.run(require('./routes.cjsx')(App), Router.HistoryLocation, (Handler) ->
  React.render(<Handler />, document.getElementById('app'))
)
