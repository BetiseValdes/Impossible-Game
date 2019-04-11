HtmlWebpackPlugin = require('html-webpack-plugin')
webpack = require('webpack')
path = require('path')
UglifyJsPlugin = require('uglifyjs-webpack-plugin')

config =
  devtool: 'inline-source-map'
  entry: './src/main'
  output:
    path: path.resolve(__dirname, 'dist')
    filename: 'bundle.js'
  module: rules: [ {
    test: /\.coffee$/,
    loader: "coffee-loader"
    options: transpile: presets: ['env']
  }

  {
    test: /\.(png|jp(e*)g|gif|json|mp3|wav)$/
    use:
      loader: 'url-loader'
      options:
        limit: 800
        name: 'images/[name].[ext]'
  }]
  resolve: extensions: [".web.coffee", ".web.js", ".coffee", ".js"]
  plugins: [
    new HtmlWebpackPlugin()
  ]



module.exports = config
