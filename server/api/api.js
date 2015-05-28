var express = require('express');
var router = express.Router();
var _ = require('lodash');
var Build = require('./model/Build.js');

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
        console.log('buildNumber:', result.buildNumber);
        Build.create(result);
        return result;
      })
      .then(function (result) {
        require('shelljs/global');
        cd('nightwatchtest');
        exec('./node_modules/nightwatch/bin/nightwatch --group tests', { async: true }, function (code, output) {
          cd('..')
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
