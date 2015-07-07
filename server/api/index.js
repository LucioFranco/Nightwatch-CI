var express = require('express');
var router  = express.Router();

var buildRoutes = require('./build.js');
var userRoutes = require('./user.js');

router.use(buildRoutes);
router.use(userRoutes);

module.exports = router;
