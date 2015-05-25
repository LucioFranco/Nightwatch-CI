React = require 'react'
Navbar = require 'react-bootstrap/lib/Navbar'
Nav = require 'react-bootstrap/lib/Nav'
NavItem = require 'react-bootstrap/lib/NavItem'
Glyph = require 'react-bootstrap/lib/Glyphicon'
Router = require 'react-router'

Menu = React.createClass
  mixins: [Router.Navigation]
  render: ->
    <Navbar brand="Nightwatch Runner" inverse fixedTop toggleNavKey={0}>
      <Nav>
        <NavItem onClick={=> @transitionTo '/'}><Glyph glyph="th-large"/>  Dashboard</NavItem>
        <NavItem onClick={=> @transitionTo '/builds'}><Glyph glyph="warning-sign"/>  Builds</NavItem>
        <NavItem onClick={=> @transitionTo '/tests'}><Glyph glyph="asterisk"/>  Tests</NavItem>
      </Nav>
    </Navbar>


module.exports = Menu
