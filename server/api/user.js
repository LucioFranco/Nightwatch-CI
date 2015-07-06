var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var Build   = require('./service/userService');
var auth = require('../auth').jwt;

router.use(auth);

router
  .route('')

module.exports = router;
