var mongoose = require('mongoose');

var QueueSchema = mongoose.Schema({
  inProgress: { type: Boolean, default: true },
  buildNumber: Number,
  timestamp: { type: Date, default: Date.now },
  output: { type: String, default: 'Test in Progress' }
});

module.exports = mongoose.model('Queue', QueueSchema);
