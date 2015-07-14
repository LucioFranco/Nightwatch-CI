React = require 'react'
Router = require 'react-router'

require './style/app.less'

Header = require './components/header/header.cjsx'

RouteHandler = Router.RouteHandler

App = React.createClass
  mixins: [ Router.State ]
  render: ->
      <div>
        <Header />
        <div className="RouteHandler container">
          <RouteHandler {...@props} />
        </div>
      </div>
Router.run(require('./routes.cjsx')(App), Router.HistoryLocation, (Handler) ->
  React.render(<Handler />, document.getElementById('app'))
)
