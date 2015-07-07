var User = require('../model/User');
var bcrypt = require('bcrypt-as-promised');
var when = require('when');
var _ = require('lodash');
var jwt = require('jwt-simple');
var config = require('../../config');

var self = module.exports = {
  checkJwt: function (payload, done) {
    User
      .findOne({ _id: payload._id })
      .exec(function (err, user) {
        if (err) return done(err);
        if (!user) return done(null, false, 'Wrong Jwt payload');

        return done(null, _.pick(user, ['username', 'firstname', 'lastname', '_id', 'email', 'admin', 'timestamp']));
      });
  },
  checkLocal: function (username, password, done) {
    User
      .findOne({ username: username })
      .exec(function (err, user) {
        if (err) return done(err);
        if (!user) return done(null, false, 'Wrong Username');
        bcrypt
          .compare(password, user.password)
          .then(function (result) {
            user.auth_token = jwt.encode(_.pick(user, ['username', '_id', 'email']), config.jwt_secret);
            return done(null, _.pick(user, ['username', 'firstname', 'lastname', '_id', 'email', 'admin', 'timestamp', 'auth_token']));
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
  },
  getAllUsers: function () {
    return when.promise(function (resolve, reject) {
      User
        .find()
        .exec(function (err, res) {
          if (err) reject(err);
          resolve(res);
        });
    });
  }
};
