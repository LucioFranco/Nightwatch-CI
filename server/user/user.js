var express = require('express');
var router = express.Router();
var _ = require('lodash');
var User = require('./model/User.js');
var UserService = require('./service/UserService');
var bcrypt = require('bcrypt-as-promised');
var passport = require('passport');

router
  .post('/login', passport.authenticate('local'),function (req, res, next) {
    res.redirect('/');
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
  .get('/auth/check',function (req, res, next) {
    res.json({});
  });

module.exports = router;
