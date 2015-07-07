React = require 'react'

{ ListGroup, ListGroupItem } = require 'react-bootstrap'
teamStoreMixin = require '../../mixins/team_store.coffee'

Team = React.createClass
  mixins: [ teamStoreMixin ]

  renderTeam: ->
    team = []
    _.each @state?.team, (e) ->
      team.push <ListGroupItem><TeamMember user={e} /></ListGroupItem>

  render: ->
    <div className="container">
      <h1>Team</h1>
      <ListGroup>
        {@renderTeam()}
      </ListGroup>
    </div>
