var express = require('express');
var mongoose = require('mongoose');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var requireDir = require('require-dir');

// ##############################################################
// Pull in all the models
var models = requireDir('./models');
// Put all the models into the global namespace
for (var model in models) {
  console.log("Registering model: %j", model);
  Object.defineProperty(Object.prototype,
                        model,
                        {
                          set: function() {},
                          get: function() { return models[model]; },
                          configurable: true
  });
}

// ##############################################################
// Pull in all the services...
var services = requireDir('./services');
// Put all the services into the global namespace
for (var service in services) {
  console.log("Registering service: %j", service);
  Object.defineProperty(Object.prototype,
                        service,
                        {
                          set: function() {},
                          get: function() { return services[service]; },
                          configurable: true
  });
}

// ##############################################################
// Pull in all the configurations
var configurations = requireDir('./config');
// Register all the configurations with the globl namespace under config
Object.defineProperty(Object.prototype,
                      'config',
                      {
                        set: function() {},
                        get: function() { return configurations; },
                        configurable: true
});
// ##############################################################
// Pull in all the controllers
var controllers = requireDir('./routes');

// ##############################################################
// Mongoose settings

// Tell mongoose to use the ES6 Promise
mongoose.Promise = global.Promise;

// Connect. The URL should be externalized to a configuration file
mongoose.connect("mongodb://localhost/meanStackSPA");

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// app.use('/', routes);
app.use('/token', controllers.token);
app.use('/users', controllers.users);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
