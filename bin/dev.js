var app = require('../index.js');
var path = require('path');

var config = {
  dev: true,
  test: true,
  noCompile: true,
  createAdmin: true,
  jobRunner: {
    repeat: 20000,
    nightwatchConfig: {
      args: [
        '--group',
        '-e',
        'chrome'
      ],
      testPath: path.join(process.cwd(), 'test/nightwatch')
    },
    before: function (info, done) {
      console.log('before', info);
      done()
    },
    after: function (result) {
      console.log('after', result);
      return;
    }
  }
}

app.init(config);
app.start();
