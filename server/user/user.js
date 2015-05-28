var express = require('express');
var router = express.Router();
var _ = require('lodash');
var User = require('./model/User.js');
var bcrypt = require('bcrypt-as-promised');

router
  .post('/login', function (req, res, next) {
    res.status(200);
  });

router
  .post('/', function (req, res, next) {
    if (!req.body.name || !req.body.username || !req.body.password || !req.body.email)
      next({ status: 400, msg: 'Missing something' })
    bcrypt
      .genSalt(10)
      .then(function (result) {
        bcrypt
          .hash(req.body.password, result)
          .then(function (result) {
            User.create({
              name: req.body.name,
              username: req.body.username,
              password: result,
              email: req.body.email
            }).exec()
            .then(function (result) {
              res.status(200);
            });
          });
      });
  });

module.exports = router;
