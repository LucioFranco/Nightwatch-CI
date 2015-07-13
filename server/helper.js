var _ = require('lodash');

exports.json = function (res, status) {
  return function (result) {
    if (!status)
      status = 200;
    res.status(status).json(result).end();
  }
};

exports.err = function (next, status) {
  return function (err) {
    var defaultErr = {
      status: 500,
      json: {}
    }

    if (status)
      err.status = status;
    if (err)
      err.json = err;
    next(_.merge(defaultErr, err));
  }
};
