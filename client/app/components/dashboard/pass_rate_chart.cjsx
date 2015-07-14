React = require 'react'
require 'chart.js'
PieChart = require 'react-chartjs/lib/Pie'
Reflux = require 'reflux'
BuildStore = require '../../stores/BuildStore.coffee'
QueueStore = require '../../stores/QueueStore.coffee'

PassRateChart = React.createClass
  mixins: [Reflux.connect(BuildStore, 'builds'), Reflux.connect(QueueStore, 'queue')]
  getData: ->
    pass = 0
    fail = 0
    inProgress = @state.queue?.length || 0
    _.each @state.builds, (e) ->
      if _.has e, 'inProgress'
        inProgress++
      else if e.pass
        pass++
      else
        fail++

    data = [
        {
            value: fail,
            color:"#F7464A",
            highlight: "#FF5A5E",
            label: "Fail"
        },
        {
            value: pass,
            color: "#46BFBD",
            highlight: "#5AD3D1",
            label: "Pass"
        },
        {
            value: inProgress,
            color: "#FDB45C",
            highlight: "#FFC870",
            label: "In Progress"
        }
    ]

  render: ->
    <div className="text-center">
      {if @state.builds?.length > 0 then <PieChart data={@getData()} /> else <h4 className="panel-body-text">No Builds in the System</h4>}
    </div>

module.exports = PassRateChart
