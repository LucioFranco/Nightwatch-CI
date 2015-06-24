var express = require('express');
var router = express.Router();
var _ = require('lodash');
var Build = require('./model/Build.js');
var worker = require('../worker');

router
  .get('/build', function (req, res) {
    Build
      .find({})
      .sort('buildNumber')
      .exec()
      .then(function (doc) {
        res.json(_.each(doc, function (e) {e.output = JSON.parse(e.output)}));
      });
  });

router
  .post('/build/start', function (req, res) {
    Build.find().sort('buildNumber').exec()
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
        Build.create(result);
        return result;
      })
      .then(function (result) {
        worker.runNightwatch(function (pass, results) {
          Build.update(
            { buildNumber: result.buildNumber },
            { inProgress: false, pass: pass, output: JSON.stringify(results) }
          )
          .exec()
          .then(function (response) {
            res.io.emit('buildStoreUpdate', { msg: response });
          });
        })
      });
      res.status(200);
  });

module.exports = router;
