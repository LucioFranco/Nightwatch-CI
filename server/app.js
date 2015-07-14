var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var bodyParser = require('body-parser');

var auth = require('./auth');

var apiRoutes = require('./api');
var authRoutes = require('./auth/auth.js');

var mongoose = require('mongoose');
var Build = require('./api/service/buildService');
var worker  = require('./worker');

var winston = require('winston');

module.exports = function (config) {
  var db = mongoose.connect(process.env.mongodb_uri || config.mongoUri);
  var jobRunner = worker.startJobRunner(config.jobRunner, io, Build.finished(io));

  app.use(bodyParser.urlencoded({extended: false}));
  app.use(bodyParser.json());
  app.use(auth.init());
  app.use(function (req, res, next) {
    req.io = io;
    req.jobRunner = jobRunner;
    req.config = config;

    if (config.log_level)
      winston.level = config.log_level;
    winston.info(req.method + ' ' + req.url);
    next();
  });

  app.use('/auth', authRoutes);
  app.use('/api', apiRoutes);

  app.use(function (err, req, res, next) {
    if (typeof err === 'Number')
      res.status(err);
    else {
      winston.error('[Error]', err.stack || err.msg || err.message);
      res.status(err.status || err.code || 500).send('[Error] ' + (err.stack || err.msg || err.message || err.json));
    }
  });

  app.server = server;

  return app;
};
