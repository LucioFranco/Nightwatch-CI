React = require 'react'
Navbar = require 'react-bootstrap/lib/Navbar'
Nav = require 'react-bootstrap/lib/Nav'
NavItem = require 'react-bootstrap/lib/NavItem'
Glyph = require 'react-bootstrap/lib/Glyphicon'
Router = require 'react-router'
Link = Router.Link

Menu = React.createClass
  mixins: [Router.Navigation]
  render: ->
    <Navbar brand={<Link to='/'>Nightwatch Runner</Link>}" inverse fixedTop toggleNavKey={0}>
      <Nav>
        <NavItem onClick={=> @transitionTo '/'}><Glyph glyph="th-large"/>  Dashboard</NavItem>
        <NavItem onClick={=> @transitionTo '/builds'}><Glyph glyph="warning-sign"/>  Builds</NavItem>
        <NavItem onClick={=> @transitionTo '/tests'}><Glyph glyph="asterisk"/>  Tests</NavItem>
        <NavItem onClick={=> @transitionTo '/admin'}><Glyph glyph="asterisk"/>  Admin</NavItem>
      </Nav>
    </Navbar>


module.exports = Menu
