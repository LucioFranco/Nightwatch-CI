var app = require('../index.js');
var path = require('path');

var config = {
  dev: true,
  gulp: true,
  jobRunner: {
    repeat: 200000,
    nightwatchConfig: {
      args: ['--group'],
      testPath: path.join(process.cwd(), 'nightwatchtest')
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
