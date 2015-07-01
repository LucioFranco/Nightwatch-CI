var when = require('when');
var Build = require('../model/build');

var self = module.exports = {
  getAllBuilds: function () {
    return when.promise(function (resolve, reject, notify) {
      Build
        .find({})
        .sort('buildNumber')
        .exec()
        .then(function(result) {
          resolve(result);
        });
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
          resolve(number);
        });
    });
  },
  create: function (result) {
    return when.promise(function (resolve, reject, notify) {
      var doc = {
        buildNumber: result.buildNumber,
        pass: result.pass,
        output: JSON.stringify(result.results)
      }

      Build
        .create(doc, function () {
          resolve();
        });
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