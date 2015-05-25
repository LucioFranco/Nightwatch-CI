module.exports = {
	devtool: 'sourcemap',
	entry: [
		__dirname + '/client/app/app.cjsx'
	],
	output: {
		filename: 'bundle.js'
	},
	debug: true,
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
};
