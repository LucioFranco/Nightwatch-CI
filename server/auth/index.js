var passport = require('passport');
var localStrategy = require('passport-local');
var jwtStrategy = require('passport-jwt');
var UserService = require('../user/service/UserService');

module.exports = {
  init: function () {
    passport.use(new localStrategy(UserService.checkLocal));
    return passport.initialize();
  }
}
