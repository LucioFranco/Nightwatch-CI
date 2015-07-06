var passport = require('passport');
var localStrategy = require('passport-local');
var jwtStrategy = require('passport-jwt').Strategy;
var UserService = require('../api/service/userService');
var config = require('../config');

module.exports = {
  init: function () {
    passport.use(new localStrategy({ session: false }, UserService.checkLocal));
    passport.use(new jwtStrategy({ secretOrKey: config.jwt_secret }, UserService.checkJwt))
    return passport.initialize();
  },
  jwt: passport.authenticate('jwt', { session: false })
}
