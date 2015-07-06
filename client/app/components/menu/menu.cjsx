React = require 'react'
Navbar = require 'react-bootstrap/lib/Navbar'
Nav = require 'react-bootstrap/lib/Nav'
NavItem = require 'react-bootstrap/lib/NavItem'
Glyph = require 'react-bootstrap/lib/Glyphicon'
Router = require 'react-router'
Link = Router.Link

UserActions = require '../../actions/UserActions.coffee'
userStoreMixin = require '../../mixins/user_store.coffee'

Menu = React.createClass
  mixins: [Router.Navigation, userStoreMixin]
  render: ->
    <Navbar brand={<Link to='/'>Nightwatch Runner</Link>} inverse fixedTop toggleNavKey={0}>
      <Nav>
        <NavItem onClick={=> @transitionTo '/'}><Glyph glyph="th-large"/>  Dashboard</NavItem>
        <NavItem onClick={=> @transitionTo '/builds'}><Glyph glyph="warning-sign"/>  Builds</NavItem>
        {<NavItem onClick={=> @transitionTo '/admin'}><Glyph glyph="asterisk"/>  Admin</NavItem> unless !@state.user?.admin}
      </Nav>
      <Nav pullRight>
        <NavItem onClick={UserActions.logout}>Logout</NavItem>
      </Nav>
    </Navbar>


module.exports = Menu
