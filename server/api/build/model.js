var mongoose = require('mongoose');

var BuildSchema = mongoose.Schema({
  pass: Boolean,
  inProgress: Boolean,
  buildNumber: Number,
  timestamp: { type: Date, default: Date.now },
  output: String
});

module.exports = mongoose.model('Builds', BuildSchema);
