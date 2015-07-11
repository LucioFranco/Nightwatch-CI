var gulp	 		= require('gulp'),
		webpack		= require('webpack-stream'),
		path			= require('path'),
		lodash 		= require('lodash'),
		nodemon 	= require('gulp-nodemon')
		sync 			= require('run-sequence');

var paths = {
	js: 'client/app/**/*',
	webpack: require('./webpack.config')(true),
	dev_server: __dirname + '/bin/dev.js',
	entry: __dirname + '/client/app/app.cjsx',
	build: __dirname + '/client/static'
};

gulp.task('build:frontend', function() {
	return gulp.src(paths.entry)
		.pipe(webpack(require('./webpack.config')(true)))
		.pipe(gulp.dest(paths.webpack.output.path));
});

gulp.task('build:backend', function () {
	nodemon({
    script: paths.dev_server,
		watch: [__dirname + '/server', __dirname + 'index.js'],
		ext: 'js coffee',
		env: { 'NODE_ENV': 'development' }
  });
});

gulp.task('watch', function(){
	gulp.watch(paths.js, ['build:frontend']);
});

gulp.task('default', ['build:frontend','build:backend', 'watch']);
