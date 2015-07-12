var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var Build   = require('./service/buildService');
var auth = require('../auth').jwt;

router
  .get('/', function (req, res, next) {
    Build
      .getAllBuilds()
      .then(function (result) {
        res.json(_.map(result, function (e) {
          e = e.toObject();
          e.output = _.omit(JSON.parse(e.output), ['modules'])
          return e;
        }));
      })
      .catch(next);
  });

router
  .get('/queue', function (req, res, next) {
    res.jobRunner.getBuildQueue()
      .then(function (result) {
        res.json(result);
      })
      .catch(next);
  });

router
  .post('/start', auth, function (req, res, next) {
    Build
      .getLastBuildNumber()
      .then(res.jobRunner.add)
      .then(function (result) {
        res.io.emit('queueStoreUpdate');
        res.status(200).json(result);
      })
      .catch(next);
  });

router
  .route('/:buildNum')
  .get(function (req, res, next) {
    Build
      .getBuildById(req.params['buildNum'])
      .then(res.json)
      .catch(next);
  })

module.exports = router;
