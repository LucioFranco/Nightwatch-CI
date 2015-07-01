React = require 'react'
Grid = require 'react-bootstrap/lib/Grid'
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'
Panel = require 'react-bootstrap/lib/Panel'
Glyph = require 'react-bootstrap/lib/Glyphicon'
Button = require 'react-bootstrap/lib/Button'
_ = require 'lodash'
QueueActions = require '../../actions/QueueActions.coffee'

Build = require './build.cjsx'
PassRateChart = require './pass_rate_chart.cjsx'
CurrentBuilds = require './current_builds.cjsx'

Dashboard = React.createClass
  startBuild: ->
    console.log 'button pressed'
    QueueActions.newBuild()

  render: ->
    <div className="container">
      <Grid>
        <Row>
          <Col xs={6}>
            <Panel header="Builds" bsStyle='primary'>
              <div className='well' style={{maxWidth: 400, margin: '0 auto 10px'}}>
                <Button center bsStyle='primary' onClick={@startBuild} block>Start Build</Button>
              </div>
              <br />
              <h5>Last 5 Builds</h5>
              <Build />
            </Panel>
          </Col>
          <Col xs={5}>
            <Panel header="Pass Rate" bsStyle='primary'>
              <PassRateChart />
            </Panel>
            <Panel header="Current Builds" bsStyle='primary'>
              <CurrentBuilds />
            </Panel>
          </Col>
        </Row>
      </Grid>
    </div>

module.exports = Dashboard
