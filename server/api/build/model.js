var mongoose = require('mongoose');

var BuildSchema = mongoose.Schema({
  pass: { type: Boolean, default: false },
  inProgress: { type: Boolean, default: true },
  buildNumber: Number,
  timestamp: { type: Date, default: Date.now },
  output: { type: String, default: 'Test in Progress' }
});

module.exports = mongoose.model('Builds', BuildSchema);
