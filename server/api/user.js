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
      .then(res.json)
      .catch(next);
  })
  .post(auth, function (req, res, next) {
    UserService
      .createUser(req.body, req.body.group === 'a')
      .then(res.json)
      .catch(next);
  })

module.exports = router;
