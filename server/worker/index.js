var cp = require('child_process');
var path = require('path');
var when = require('when');
var winston = require('winston');

var workers = {
  runNightwatch: function (config, buildNumber) {
    return when.promise(function (resolve, reject, notify) {
      if (!config.args && !config.testPath)
        return winston.error('no nightwatch config passed');
      var nightwatch = cp.fork(
        __dirname + '/testRunner.js',
        config.args,
        {
          cwd: config.testPath
        }
      );

      nightwatch.on('message', function (message) {
        if (typeof message === 'string')
          winston.info('message from worker' + message);
        else {
          message.buildNumber = buildNumber;
          resolve(message);
        }
      });
      nightwatch.on('err', function (err) {
        reject(err);
      });
    });
  },
  startJobRunner: function (config, io, buildDone) {
    var options = {};

    if (config.silent)
      options = {
        env: {
          silent: true
        }
      }

    var runner = cp.fork(__dirname + '/jobRunner.js', [], {  });
    runner._maxListeners = 25;
    runner.on('message', function (msg) {
      if (msg.type === 'buildCompleted') {
        if (config.after) {
          config.after(msg.result);
        }
        buildDone(msg.result);
      }else if (msg.type === 'newBuild')
        io.emit('queueStoreUpdate');
      else if (msg.type === 'preBuild')
        if (config.before) {
          var done = function () {
            runner.send({ type: 'donePreBuild' });
          };
          config.before(msg.info, done);
        }
    });
    runner.send({ type: 'config', config: config });

    return  {
      add: function (buildInfo) {
        return when.promise(function (resolve, reject) {
          runner.send({ type: 'newBuild', buildNumber: buildInfo.buildNumber, config: buildInfo.config });
          runner.on('message', function (msg) {
            if (msg.type === 'newBuild')
              resolve(msg.build);
          });
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
