Reflux = require 'reflux'

UserActions = Reflux.createActions ['auth', 'login', 'logout', 'create']

UserActions.login.preEmit = (data) -> data
UserActions.create.preEmit = (data) -> data

module.exports = UserActions
