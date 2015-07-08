var express = require('express');
var router = express.Router();
var _ = require('lodash');
var User = require('../api/model/User.js');
var UserService = require('../api/service/userService');
var bcrypt = require('bcrypt-as-promised');
var passport = require('passport');

router
  .post('/login', passport.authenticate('local', { session: false }),function (req, res) {
    res.json(req.user);
  });

router
  .post('/create/admin/once', function (req, res, next) {
    UserService
      .createUser(req.body, true)
      .then(function () {
        res.redirect('/');
      })
      .catch(function (err) {
        next(err);
      });
  });

router
  .get('/check', passport.authenticate('jwt', { session: false }),function (req, res, next) {
    res.json(req.user);
  });

module.exports = router;
