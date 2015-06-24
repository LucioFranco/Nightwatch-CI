var cp = require('child_process');
var path = require('path');

var workers = {
  runNightwatch: function (cb) {
    console.log('hello');
    var nightwatch = cp.fork(
      __dirname + '/testRunner.js',
      [
        '--group',
        'rx/default/account',
        '-e',
        'local-chrome'
      ],
      {
        cwd: path.join(path.join(process.cwd(), '..'), 'OmbudPlatform/qa/functional')
      }
      );
    nightwatch.on('message', function (message) {
      if (typeof message === 'string')
        console.log(message);
      else
        cb(message.pass, message.results)
    });
    nightwatch.on('err', function (err) {
      console.log(err);
    });
  }
};

module.exports = workers;
