var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);

var apiRoutes = require('./api/api.js');
var authRotes = require('./user/user.js');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');
var userRoutes = require('./user/user.js');
var Build = require('./api/service/buildService');
var worker  = require('./worker');
var jobRunner = worker.startJobRunner(Build.finished(io));

module.exports = function () {
  var db = mongoose.connect('mongodb://localhost/nightwatch');

  app.set('jwt-secret', 'bannasarecool');

  app.use(bodyParser.json());
  app.use(function (req, res, next) {
    res.io = io;
    res.jobRunner = jobRunner;
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    console.log(req.method + ' ' + req.url);
    next();
  });

  app.use('/user', userRoutes);
  app.use('/api', apiRoutes);

  app.use(function (err, req, res, next) {
    if (typeof err === 'Number')
      res.status(err);
    else
      console.error(err.stack);
      res.status(err.status);
  });

  app.server = server;

  return app;
};
