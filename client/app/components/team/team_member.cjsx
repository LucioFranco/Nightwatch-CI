React = require 'react'

TeamMember = React.createClass
  render: ->
    <div>
      {@props.user?.firstname}
    </div>

module.exports = TeamMember
