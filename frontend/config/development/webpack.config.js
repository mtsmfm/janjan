module.exports = {
  entry: {
    polyfills: './app/polyfills.ts',
    application: './app/main.ts'
  },
  output: {
    path: '../app/assets/javascripts/frontend',
    filename: '[name].js'
  },
  resolve: {
    extensions: ['', '.webpack.js', '.web.js', '.ts', '.js']
  },
  module: {
    loaders: [
      { test: /\.tsx?$/, loader: 'ts-loader' }
    ]
  }
}
