var when = require('when');
var Build = require('../model/Build');
var _ = require('lodash');

var self = module.exports = {
  getAllBuilds: function (size) {
    return when.promise(function (resolve, reject, notify) {
      Build
        .find({})
        .sort({'buildNumber': -1})
        .limit(size)
        .exec()
        .then(resolve, reject);
    });
  },
  getBuildByBuildNum: function (buildNum) {
    return when.promise(function (resolve, reject) {
      Build
        .findOne({ buildNumber: buildNum })
        .exec()
        .then(resolve, reject);
    });
  },
  getLastBuildNumber: function () {
    return when.promise(function (resolve, reject, notify) {
      Build
        .find()
        .sort('buildNumber')
        .exec()
        .then(function(result) {
          var number;
          if (result.length > 0)
            number = result[result.length - 1].buildNumber + 1;
          else
            number = 1;
          resolve({ buildNumber: number });
        });
    });
  },
  getStats: function (size) {
    return when.promise(function (resolve, reject) {
      self
        .getAllBuilds(size)
        .then(function (result) {
          return _.map(result, function (e) {
            return JSON.parse(e.output).modules;
          });
        })
        .then(function (result) {
          var tests = {};
          _.each(result, function (e) {
            _.mapKeys(e, function (e, key) {
              if (!_.has(tests, key)) {
                tests[key] = 0;
              }

              if (e.failures > 0) {
                tests[key] += 1;
              }
            });
          });
          return tests;
        })
        .then(resolve)
        .catch(reject);
    });
  },
  create: function (result) {
    return when.promise(function (resolve, reject, notify) {
      var doc = {
        buildNumber: result.buildNumber,
        pass: result.pass,
        started_at: result.started_at,
        finished_at: result.finished_at,
        output: JSON.stringify(result.results)
      }

      Build
        .create(doc, resolve);
    });
  },
  finished: function (io) {
    return function (result) {
      return self
        .create(result)
        .then(function (result) {
          io.emit('buildStoreUpdate');
          io.emit('queueStoreUpdate');
        });
    }
  }
};
