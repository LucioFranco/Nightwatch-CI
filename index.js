#! /usr/bin/env node
var express = require('express');
var app = require('./server/app.js')();
var webpack = require('webpack');

// TODO: add flags and options for command line tool
webpack(require('./webpack.config.js')(false));

if (process.env.NODE_ENV != 'development') {
  app.use('/', express.static(__dirname + '/client/static'));
}

app.listen(process.env.BACKEND_PORT || 3000);
