var mongoose = require('mongoose');

var BuildSchema = mongoose.Schema({
  pass: { type: Boolean},
  buildNumber: Number,
  started_at: Date,
  finished_at: { type: Date, default: Date.now },
  output: { type: String, default: 'No Output from Nightwatch' }
});

module.exports = mongoose.model('Builds', BuildSchema);
