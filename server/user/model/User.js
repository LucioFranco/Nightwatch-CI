var mongoose = require('mongoose');

var UserSchema = mongoose.Schema({
  name: String,
  username: String,
  password: String,
  email: String,
  timestamp: { type: Date, default: Date.now },
  githubUsername: { type: String, default: 'No Account' }
});

module.exports = mongoose.model('Users', UserSchema);
