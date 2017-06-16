const postcss = require('postcss');
const postcssJs = require('postcss-js');

module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-each'),
    require('postcss-cssnext')
  ]
}
