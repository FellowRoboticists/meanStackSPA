module.exports = (function() {

  var requireDir = require('require-dir');

  // ##############################################################
  // Pull in all the configurations
  var configurations = requireDir('./config');
  // Register all the configurations with the globl namespace under config
  global.config = configurations;

  // We want lodash to be globally available.
  // global._ = require('lodash');

  var mod = {
  };

  return mod;

}());
