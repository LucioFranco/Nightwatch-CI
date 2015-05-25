var express = require('express');
var app = express();
var apiRoutes = require('./api/apiRoutes.js');
var mongoose = require('mongoose');

module.exports = function () {
  var db = mongoose.connect('mongodb://localhost/nightwatch');

  app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    console.log(req.method + ' ' + req.url);
    next();
  });

  app.use('/api', apiRoutes);

  return app;
};
