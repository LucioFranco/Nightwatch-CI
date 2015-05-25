React = require 'react'

Menu = require '../menu/menu.cjsx'

Header = React.createClass
  render: ->
    <div className="container">
      <Menu />
    </div>

module.exports = Header
