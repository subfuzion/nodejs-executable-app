// webpack.config.js
const path = require('path');

module.exports = {
  target: 'node',
  entry: './bin/app.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, '.build'),
  },
  mode: "production",
};
