var express = require('express');
var router = express.Router();
var _ = require('lodash');
var Build = require('./build/model.js');

router
  .get('/build', function (req, res) {
    Build
      .find({})
      .sort('buildNumber')
      .exec()
      .then(function (doc) {
        res.json(doc);
      });
  });

router
  .post('/build/start', function (req, res) {
    Build.find().sort('buildNumber').exec()
      .then(function (result) {
        var number = result[result.length - 1].buildNumber + 1;
        return {
          buildNumber: number
        }
      })
      .then(function (result) {
        Build.create(result);
        return result;
      })
      .then(function (result) {
        require('shelljs/global');
        cd('nightwatchtest');
        exec('./node_modules/nightwatch/bin/nightwatch --group tests', { async: true }, function (code, output) {
          var pass = code === 0 ? true : false;
          Build.update(
              { buildNumber: result.buildNumber },
              { inProgress: false, pass: pass, output: output }
            )
            .exec()
            .then(function (response) {
              res.json(response);
            });
        });
      });

  });

module.exports = router;
