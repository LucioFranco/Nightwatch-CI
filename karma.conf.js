module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['mocha'],


    // list of files / patterns to load in the browser
    files: [
        { pattern: 'spec.bundle.js', watched: false }
    ],


    // list of files to exclude
    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
        'spec.bundle.js': ['webpack', 'sourcemap']
    },

    webpack: {
        devtool: 'inline-source-map',
        module: {
            loaders: [
              { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
              { test: /\.js$/, exclude: [/app\/lib/, /node_modules/], loader: 'babel' },
              { test: /\.html$/, loader: 'raw' },
              { test: /\.less$/, loader: 'style!css!less' },
              { test: /\.styl$/, loader: 'style!css!stylus' },
              { test: /\.css$/, loader: 'style!css' },
              { test: /\.coffee$/, loader: "coffee-loader" },
              { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" },

              // Needed for the css-loader when [bootstrap-webpack](https://github.com/bline/bootstrap-webpack)
              // loads bootstrap's css.
              { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,   loader: "url?limit=10000&minetype=application/font-woff" },
              { test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/,   loader: "url?limit=10000&minetype=application/font-woff" },
              { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,    loader: "url?limit=10000&minetype=application/octet-stream" },
              { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,    loader: "file" },
              { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,    loader: "url?limit=10000&minetype=image/svg+xml" }
            ]
        }
    },

    webpackServer: {
      noInfo: true //please don't spam the console when running in karma!
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['mocha'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: true
  });
};
