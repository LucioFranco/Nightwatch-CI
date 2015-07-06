var User = require('../model/User');
var bcrypt = require('bcrypt-as-promised');
var when = require('when');

var self = module.exports = {
  checkLocal: function (username, password, done) {
    User
      .findOne({ username: username })
      .exec(function (err, user) {
        if (err) return done(err);
        if (!user) return done(null, false, 'Wrong Username');
        bcrypt
          .compare(password, user.password)
          .then(function (result) {
            return done(null, user);
          })
          .catch(function (err) {
            return done(null, false, { message:'Wrong Password' });
          })
      });
  },
  validateUser: function (username) {
    return when.promise(function (resolve, reject) {
      User
        .findOne({username: username}, function (err, result) {
          if (!result)
            resolve();
          else
            reject({ status: 401, msg: 'User already exists' });
        });
    });
  },
  createUser: function (body, admin) {
    return when.promise(function (resolve, reject) {
      self
        .validateUser(body.username)
        .then(function () {
          if (!admin)
            admin = false;
          if (!body.firstname || !body.lastname || !body.username || !body.password || !body.email)
            reject({ status: 401, msg: 'Missing something' });
          return bcrypt.hash(body.password, 10);
        })
        .then(function (result) {
          User
            .create({
              firstname: body.firstname,
              lastname: body.lastname,
              username: body.username,
              password: result,
              email: body.email,
              admin: admin
            },
            function (err) {
              if (err) reject(err);
              resolve();
            })
        })
        .catch(function (err) {
          reject(err);
        })
    });
  }
};
