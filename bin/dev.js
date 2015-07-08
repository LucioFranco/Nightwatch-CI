var app = require('../index.js');

var config = {
  dev: true,
  nightwatchConfig: {
    args: ['--group'],
    testPath: __dirname + '/nightwatchtest'
  }
}

app.init(config);
app.start();
