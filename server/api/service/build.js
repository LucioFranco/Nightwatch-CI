var when = require('when');
var Build = require('../model/build');

module.exports = {
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
          resolve(result);
        });
    });
  },
  create: function (doc) {
    return when.promise(function (resolve, reject, notify) {
      Build
        .create(doc, function () {
          resolve(doc);
        });
    });
  },
  updateBuild: function (result) {
    return when.promise(function (resolve, reject, notify) {
      Build
        .update(
          { buildNumber: result.buildNumber },
          { inProgress: false, pass: result.pass, output: JSON.stringify(result.results) },
          function (response) {
            resolve(response);
          }
        );
    });
  }
};
