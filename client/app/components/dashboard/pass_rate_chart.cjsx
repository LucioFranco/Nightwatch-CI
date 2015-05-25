React = require 'react'
require 'chart.js'
PieChart = require 'react-chartjs/lib/Pie'
Reflux = require 'reflux'
BuildStore = require '../../stores/BuildStore.coffee'

PassRateChart = React.createClass
  mixins: [Reflux.connect(BuildStore, 'builds')]
  getData: ->
    pass = 0
    fail = 0
    inProgress = 0
    _.each @state.builds, (e) ->
      if e.inProgress
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
    <PieChart data={@getData()}/>

module.exports = PassRateChart
