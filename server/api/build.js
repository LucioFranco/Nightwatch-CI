var express = require('express');
var router  = express.Router();
var _       = require('lodash');
var Build   = require('./service/buildService');
var auth    = require('../auth').jwt;
var helper  = require('../helper');

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
    req.jobRunner.getBuildQueue()
      .then(function (result) {
        res.json(result);
      })
      .catch(next);
  });

router
  .post('/start', auth, function (req, res, next) {
    Build
      .getLastBuildNumber()
      .then(function (result) {
        return _.merge(result, { config: _.merge(req.config.jobRunner.nightwatchConfig, res.body) });
      })
      .then(req.jobRunner.add)
      .then(function (result) {
        req.io.emit('queueStoreUpdate');
        res.status(200).json(result);
      })
      .catch(next);
  });

router
  .route('/:buildNum')
  .get(function (req, res, next) {
    Build
      .getBuildByBuildNum(req.params['buildNum'])
      .then(function (result) {
        if (!result)
          helper.err(next, 404)({ msg: 'Cannont find' });
        else
          helper.json(res)(result);
      })
      .catch(helper.err(next));
  })

module.exports = router;
