var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var Build   = require('./service/buildService');

router
  .get('/build', function (req, res) {
    Build
      .getAllBuilds()
      .then(function (result) {
        res.json(result);
      });
  });

router
  .get('/build/queue', function (req, res) {
    res.jobRunner.getBuildQueue()
      .then(function (result) {
        res.json(result);
      })
      .catch(function (err) {
        console.error(err);
      });
  });

router
  .post('/build/start', function (req, res) {
    Build
      .getLastBuildNumber()
      .then(function (result) {
        return res.jobRunner.add(result);
      })
      .then(function () {
        res.status(200).json({});
      })
      .catch(function (err) {
        console.error(err);
      });
  });

module.exports = router;
