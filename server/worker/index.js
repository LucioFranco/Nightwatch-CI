var cp = require('child_process');
var path = require('path');
var when = require('when');

var workers = {
  runNightwatch: function (buildNumber) {
    return when.promise(function (resolve, reject, notify) {
      var nightwatch = cp.fork(
        __dirname + '/testRunner.js',
        [
          '--group',
          'rx/default/account',
          '-e',
          'staging-chrome'
        ],
        {
          cwd: path.join(path.join(process.cwd(), '..'), 'OmbudPlatform/qa/functional')
        }
      );
      console.log(nightwatch);
      nightwatch.on('message', function (message) {
        if (typeof message === 'string')
          console.log('message from worker' + message);
        else {
          message.buildNumber = buildNumber;
          resolve(message);
        }
      });
      nightwatch.on('err', function (err) {
        console.log(err);
        reject(err);
      });
    });
  }
};

module.exports = workers;
