module.exports = (function() {

  var requireDir = require('require-dir');

  // ##############################################################
  // Pull in all the models
  var models = requireDir('./models');
  // Put all the models into the global namespace
  for (var model in models) {
    global[model] = models[model];
  }

  // ##############################################################
  // Pull in all the services...
  var services = requireDir('./services');
  // Put all the services into the global namespace
  for (var service in services) {
    global[service] = services[service];
  }

  // ##############################################################
  // Pull in all the configurations
  var configurations = requireDir('./config');
  // Register all the configurations with the globl namespace under config
  global.config = configurations;

  var mod = {
  };

  return mod;

}());
