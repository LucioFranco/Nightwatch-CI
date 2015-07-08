var mongoose = require('mongoose');

var ApiKeySchema = mongoose.Schema({
  name: String,
  timestamp: { type: Date, default: Date.now }
});

module.exports = mongoose.model('ApiKeys', ApiKeySchema);
