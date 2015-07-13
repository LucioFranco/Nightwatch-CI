React = require 'react'
Fromsy = require 'formsy-react'
_ = require 'lodash'

{ Input } = require 'formsy-react-components'

ServiceActions = require '../../actions/ServiceActions.coffee'

GenKey = React.createClass
  getInitialState: ->
    api_key: ''

  onValidSubmit: (res) ->
    ServiceActions
      .genKey.triggerPromise(res.name)
      .then (result) =>
        @setState api_key: result.api_key
  render: ->
    console.log @state
    <div>
      {<span>{ @state.api_key }</span> unless @state.api_key == ''}
      <Formsy.Form onValidSubmit={@onValidSubmit} >
        <Input
          name="name"
          value=""
          label="Name of accesor"
          type="text"
          placeholder="Enter name"
          required
        />
        <input
          className="btn btn-primary"
          formNoValidate={true}
          type="submit"
          defaultValue="Generate Key"
        />
      </Formsy.Form>
    </div>

module.exports = GenKey
