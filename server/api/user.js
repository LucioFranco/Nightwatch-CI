var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var UserService   = require('./service/userService');
var auth = require('../auth').jwt;

router
  .route('/')
  .get(function (req, res, next) {
    UserService
      .getAllUsers()
      .then(function (result) {
        console.log(result);
        res.json(result);
      })
      .catch(function (err) {
        next(err);
      });
  })
  .post(auth, function (req, res, next) {
    UserService
      .createUser(req.body, req.body.group === 'admin')
      .then(function () {
        res.json({});
      })
      .catch(function (err) {
        next(err);
      });
  })

module.exports = router;
