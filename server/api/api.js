var express = require('express');
var router = express.Router();
var _ = require('lodash');
var Build = require('./service/Build.js');
var worker = require('../worker');

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

  });

router
  .post('/build/start', function (req, res) {
    Build
      .getLastBuildNumber()
      .then(function (result) {
        var number;

        if (result.length > 0)
          number = result[result.length - 1].buildNumber + 1;
        else
          number = 1;

        return {
          buildNumber: number
        }
      })
      .then(function (result) {
        console.log('buildNumber:', result.buildNumber);
        return Build.create(result);
      })
      .then(function (result) {
        return worker
          .runNightwatch(result.buildNumber);
      })
      .then(function (result) {
        console.log('result' + result);
        return Build.updateBuild(result);
      })
      .then(function (result) {
        res.io.emit('buildStoreUpdate', { msg: result });
      })
      .catch(function (err) {
        console.log('error' + err);
      });
      res.status(200);
  });

module.exports = router;
