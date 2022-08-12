const webpack = require('webpack');
const path = require('path');
const globalVars = require('./src/styles/var.js');

module.exports = {
	devServer: {
		port: 8081,
		proxy: {
			'^/api': {
				target: 'http://localhost:8080',
				pathRewrite: {'^/api': ''}
			},
			'^/file': {
				target: 'http://localhost:8080'
			}
		}
	},
	configureWebpack: {
		plugins: [
			new webpack.ProvidePlugin({
				'HeyUI': 'heyui',
				'HeyUtils': 'hey-utils',
				'G': 'hey-global',
				'Api': [path.resolve(__dirname, 'src/api'), 'default'],
				'Ajax': [path.resolve(__dirname, 'src/js/common/ajax.js'), 'default'],
			})
		]
	},
	css: {
		loaderOptions: {
			less: {
				globalVars
			}
		}
	}
}
