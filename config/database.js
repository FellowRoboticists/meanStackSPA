module.exports = ( () => {

  var mongoose = require('mongoose');

  // Configure mongoose to use the ES6 Promise
  mongoose.Promise = global.Promise;

  var mod = {
    url: "mongodb://localhost/meanStackSPA"
  };

  return mod;

}());
