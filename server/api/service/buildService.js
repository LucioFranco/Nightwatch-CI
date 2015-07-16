var when = require('when');
var Build = require('../model/Build');

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
