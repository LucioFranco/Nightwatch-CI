var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');

var auth = require('./auth');

var apiRoutes = require('./api');
var authRoutes = require('./auth/auth.js');

var mongoose = require('mongoose');
var Build = require('./api/service/buildService');
var worker  = require('./worker');

module.exports = function (config) {
  if (config.test) {
    var mockgoose = require('mockgoose');
    mockgoose(mongoose);
  }
  var db = mongoose.connect(config.mongoUri || process.env.mongodb_uri || 'mongodb://localhost/nightwatch');
  var jobRunner = worker.startJobRunner(config.jobRunner, io,Build.finished(io));

  app.use(cookieParser());
  app.use(bodyParser.urlencoded({extended: false}));
  app.use(bodyParser.json());
  app.use(auth.init());
  app.use(function (req, res, next) {
    res.io = io;
    res.jobRunner = jobRunner;

    console.log(req.method + ' ' + req.url);
    next();
  });

  app.use('/auth', authRoutes);
  app.use('/api', apiRoutes);

  app.use(function (err, req, res, next) {
    if (typeof err === 'Number')
      res.status(err);
    else {
      console.error('[Error]', err.stack || err.msg || err.message);
      res.status(err.status || err.code).send('[Error] ' + (err.stack || err.msg || err.message));
    }
  });

  app.server = server;

  return app;
};
