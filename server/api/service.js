var express = require('express');
var router = express.Router();
var auth = require('../auth').jwt;

var ApiKey = require('./service/apiKeyService');

router
  .route('/key')
  .post(auth, function (req, res, next) {
    ApiKey
      .genKey(req.body.name)
      .then(function (result) {
        res.json(result);
      })
      .catch(function (err) {
        res.json(err).status(500);
      });
  });

module.exports = router;
