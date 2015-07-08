React = require 'react'

TeamMember = React.createClass
  render: ->
    <div>
      {@props.user?.firstname + ' ' + @props.user?.lastname}
    </div>

module.exports = TeamMember
