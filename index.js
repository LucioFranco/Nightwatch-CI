#! /usr/bin/env node
var express = require('express');
var app = require('./server/app.js')();
var webpack = require('webpack');

// TODO: add flags and options for command line tool
webpack(require('./webpack.config.js')(false));

app.use(express.static(__dirname + '/client/static'));

app.server.listen(process.env.BACKEND_PORT || 3000);
