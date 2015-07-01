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
  },
  startJobRunner: function (buildDone) {
    var runner = cp.fork(__dirname + '/jobRunner.js');

    runner._maxListeners = 25;
    runner.on('message', function (msg) {
      if (msg.type === 'buildCompleted')
        buildDone(msg.result);
    });

    return  {
      add: function (buildNumber) {
        return when.promise(function (resolve, reject) {
          runner.send({ type: 'newBuild', buildNumber: buildNumber });
          runner.on('message', function (msg) {
            if (msg.type === 'newBuild')
              resolve();
          })
        });
      },
      getCurrentBuild: function () {
        return when.promise(function (resolve, reject) {
          runner.send({ type: 'currentBuild' });
          runner.on('message', function (msg) {
            if (msg.type === 'currentBuild')
              resolve(msg.result);
          });
        });
      },
      getBuildQueue: function () {
        return when.promise(function (resolve, reject) {
          runner.send({ type: 'buildQueue' });
          runner.on('message', function (msg) {
            if (msg.type === 'buildQueue') {
                resolve(msg.results);
            }
          });
        });
      }
    }
  }
};

module.exports = workers;
