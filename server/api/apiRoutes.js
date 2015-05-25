var express = require('express');
var router = express.Router();
var _ = require('lodash');
var Build = require('./build/model.js');

var builds = [
  { pass: true, inProgress: false, buildNumber: 1, output: "All tests passed" }
];

router
  .get('/build', function (req, res) {
    res.json(builds)
  });

router
  .get('/build/start', function (req, res) {
    build = {
      pass: false
    }
    require('shelljs/global');
    cd('nightwatchtest');
    builds.push({ pass: true, inProgress: true, buildNumber: builds.length + 1 });
    exec('./node_modules/nightwatch/bin/nightwatch --group tests', { async: true },function (code, output) {
      var pass = code === 0 ? true : false;
      builds[builds.length - 1] = _.extend(builds[builds.length - 1], { pass: pass, inProgress: false, output: output });
      res.json({ output: output, code: code })
    });
  });

module.exports = router;
