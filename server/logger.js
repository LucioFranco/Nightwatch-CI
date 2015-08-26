var winston = require('winston');

module.exports = new (winston.Logger)({
  transports: [
    new (winston.transports.Console)(),
    new (winston.transports.File)({
      tailable: true,
      colorize: true,
      filename: "nightwatch-ci.log",
      prettyPrint: true,
      json: false
    })
  ]
});
