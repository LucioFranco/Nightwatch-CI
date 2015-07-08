var express = require('express');
var app = require('./server/app.js')();
var webpack = require('webpack');
var _ = require('lodash');
var path = require('path');

var paths = {
  index: __dirname + '/client/static/index.html',
  static: __dirname + '/client/static'
};

module.exports = {
  init: function (dev, createAdmin) {
    if (createAdmin) {
      var again = true;
      app.get('/create', function (req, res) {
        if (again)
          res.sendFile(__dirname + '/server/static/createAdmin.html')
        else
          res.redirect('/');
      });
    }
    // TODO: add flags and options for command line tool
    webpack(require('./webpack.config.js')(dev));
  },
  use: function (middleware) {
    app.use(middleware);
  },
  register: function (plugin) {
    //TODO figure plugin system out
  },
  start: function () {
    app.get('/*', function (req, res) {
      if (multiStringMatch(req.originalUrl, [ '.woff2', '.woff', '.ttf', '.js', '.ico' ]))
        res.sendFile(path.join(paths.static, getFinalEndpoint(req.originalUrl)))
      else
        res.sendFile(paths.index);
    });

    app.server.listen(process.env.BACKEND_PORT || 3000);
  }
}

///HELPERS///
function multiStringMatch(str, list) {
  var match = false;
  _.each(list, function (e) {
    if (str.indexOf(e) > 0) match = true;
  });
  return match;
}

function getFinalEndpoint(url) {
  return _.last(url.split("/"));
}
