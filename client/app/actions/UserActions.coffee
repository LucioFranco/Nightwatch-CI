Reflux = require 'reflux'

UserActions = Reflux.createActions ['auth', 'login', 'logout']

UserActions.login.preEmit = (data) -> data

module.exports = UserActions
