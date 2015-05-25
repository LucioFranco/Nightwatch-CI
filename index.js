#! /usr/bin/env node
var app = require('./server/app.js')();

if (process.env.NODE_ENV != 'development') {
  app.use('/static', express.static(__dirname + '/client/static'));
  app.use('/', function (req, res) {
    res.sendFile(__dirname + '/client/index.html');
  });
}

app.listen(process.env.BACKEND_PORT || 3000);
