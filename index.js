#! /usr/bin/env node
var argv = require('minimist')(process.argv.slice(2));
var express = require('express');
var app = require('./server/app.js')();
var webpack = require('webpack');

// TODO: add flags and options for command line tool
webpack(require('./webpack.config.js')(false));

if (argv.c) {
  var again = true;
  app.get('/create', function (req, res) {
    if (again)
      res.sendFile(__dirname + '/server/static/createAdmin.html')
    else
      res.redirect('/');
  });
}

app.use(express.static(__dirname + '/client/static'));

app.server.listen(process.env.BACKEND_PORT || 3000);
