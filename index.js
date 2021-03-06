var express = require('express');
var app;
var webpack = require('webpack');
var _ = require('lodash');
var path = require('path');

var paths = {
  index: __dirname + '/client/static/index.html',
  static: __dirname + '/client/static'
};

var defaultConfig = {
  createAdmin: false,
  dev: false,
  mongoUri: 'mongodb://localhost:27017/nightwatch-ci',
  jobRunner: {
    repeat: false,
    nightwatchConfig: {
      args: [],
      testPath: process.cwd()
    }
  }
}

module.exports = {
  init: function (config) {
    config = _.merge(defaultConfig, config);
    app = require('./server/app.js')(config);
    if (config.createAdmin) {
      var again = true;
      app.get('/create', function (req, res) {
        if (again)
          res.sendFile(__dirname + '/server/static/createAdmin.html')
        else
          res.redirect('/');
      });
    }
    // TODO: add flags and options for command line tool
    if (!config.noCompile) {
      webpack(require('./webpack.config.js')(config.dev))
        .run(function (err, stats) {
          if(err)
            return console.log(err);
          var jsonStats = stats.toJson();
          if(jsonStats.errors.length > 0)
              return console.log(jsonStats.errors);
          if(jsonStats.warnings.length > 0)
              console.log(jsonStats.warnings);
          return;
        });
    }
    return app;
  },
  use: function (middleware) {
    app.use(middleware);
  },
  start: function (port) {
    app.get('/*', function (req, res) {
      if (multiStringMatch(req.originalUrl, [ '.woff2', '.woff', '.ttf', '.js', '.ico' ]))
        res.sendFile(path.join(paths.static, getFinalEndpoint(req.originalUrl)))
      else
        res.sendFile(paths.index);
    });

    app.server.listen(process.env.BACKEND_PORT || port || 3000);
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
