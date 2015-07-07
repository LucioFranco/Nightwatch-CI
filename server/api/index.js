var express = require('express');
var router  = express.Router();

var buildRoutes = require('./build.js');
var userRoutes = require('./user.js');

router.use('/build',buildRoutes);
router.use('/user', userRoutes);

module.exports = router;
