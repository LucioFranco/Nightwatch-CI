React = require('react')
Router = require('react-router')

require './app.less'

RouteHandler = Router.RouteHandler
Routes =

Header = require('./components/header/header.cjsx')

App = React.createClass
  mixins: [ Router.State ]
  render: ->
      <div>
        <Header />
        <div className="RouteHandler container">
          <RouteHandler />
        </div>
      </div>

Router.run(require('./routes.cjsx')(App), (Handler) ->
  React.render(<Handler />, app)
)
