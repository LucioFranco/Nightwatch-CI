var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var UserService   = require('./service/userService');
var auth = require('../auth').jwt;

router.use(auth);

router
  .route('/')
  .post(function (req, res, next) {
    User
      .createUser(req.body)
  })

module.exports = router;
