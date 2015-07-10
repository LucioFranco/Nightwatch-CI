var app = require('../index.js');
var path = require('path');

var config = {
  dev: true,
  gulp: true,
  jobRunner: {
    repeat: 20000,
    nightwatchConfig: {
      args: ['--group'],
      testPath: path.join(process.cwd(), 'nightwatchtest')
    },
    buildFinished: function (result) {
      return;
    }
  }
}

app.init(config);
app.start();
