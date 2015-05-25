React = require 'react'
Router = require 'react-router'
Grid = require 'react-bootstrap/lib/Grid'
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'
Panel = require 'react-bootstrap/lib/Panel'
Glyph = require 'react-bootstrap/lib/Glyphicon'
Button = require 'react-bootstrap/lib/Button'
Reflux = require 'reflux'
_ = require 'lodash'
BuildActions = require '../../actions/BuildActions.coffee'
BuildStore = require '../../stores/BuildStore.coffee'

Build = require './build.cjsx'
PassRateChart = require './pass_rate_chart.cjsx'

Dashboard = React.createClass
  mixins: [Reflux.connect(BuildStore, 'buildList')]
  renderBuilds: ->
    builds = []
    _.eachRight @state?.buildList, (e, i) ->
      builds.push <Build build={e} />
    builds

  startBuild: ->
    BuildActions.newBuild()

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
              {@renderBuilds()}
            </Panel>
          </Col>
          <Col xs={5}>
            <Panel header="Pass Rate" bsStyle='primary'>
              <div className="text-center">
                <PassRateChart />
              </div>
            </Panel>
          </Col>
        </Row>
      </Grid>
    </div>

module.exports = Dashboard
