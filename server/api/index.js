var express = require('express');
var router  = express.Router();

var buildRoutes = require('./build.js');
var userRoutes = require('./user.js');
var serviceRoutes = require('./service.js');

router.use('/build',buildRoutes);
router.use('/user', userRoutes);
router.use('/service', serviceRoutes);

module.exports = router;
