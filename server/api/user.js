var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var UserService   = require('./service/userService');
var auth = require('../auth').jwt;

router.use(auth);

router
  .route('/')
  .get(function (req, res, next) {
    User
      .getAllUsers()
      .then(function (result) {
        res.json(result);
      })
      .catch(function (err) {
        next(err);
      });
  })
  .post(function (req, res, next) {
    User
      .createUser(req.body, req.body.group === 'admin')
      .then(function () {
        res.json({});
      })
      .catch(function (err) {
        next(err);
      });
  })

module.exports = router;
