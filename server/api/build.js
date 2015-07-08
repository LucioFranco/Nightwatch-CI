var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var Build   = require('./service/buildService');
var auth = require('../auth').jwt;

router
  .get('/', function (req, res) {
    Build
      .getAllBuilds()
      .then(function (result) {
        res.json(result);
      });
  });

router
  .get('/queue', function (req, res) {
    res.jobRunner.getBuildQueue()
      .then(function (result) {
        res.json(result);
      })
      .catch(function (err) {
        console.error(err);
      });
  });

router
  .post('/start', auth, function (req, res) {
    Build
      .getLastBuildNumber()
      .then(function (result) {
        return res.jobRunner.add(result);
      })
      .then(function () {
        res.io.emit('queueStoreUpdate');
        res.status(200).json({});
      })
      .catch(function (err) {
        console.error(err);
      });
  });

module.exports = router;
