var when = require('when');
var jwt = require('jwt-simple');
var _ = require('lodash');
var config = require('../../config')

var ApiKey = require('../model/ApiKey');

exports.genKey = function (name) {
  return when.promise(function (resolve, reject) {
    if (!name)
      reject({ msg: "No name provided" });
    ApiKey
      .create({
        name: name
      },
      function (err, res) {
        if (err) reject(err);
        resolve({ api_key: jwt.encode(_.pick(res, ['_id', 'name']), config.jwt_secret) });
      })
  });
}
