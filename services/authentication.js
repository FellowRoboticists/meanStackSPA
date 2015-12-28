module.exports = (function() {

  var mongoose = require('mongoose');
  var jwt = require('jsonwebtoken');

  var createJWTToken = function(user, res) {
    var payload = {
      userId: user._id,
      // Seems odd, but ObjectId generates a random number we can use for the csrf Token
      csrfToken: new mongoose.Types.ObjectId().toString()
    };

    var token = jwt.sign(payload, config.secrets.jwtSecret, { expiresIn: 60 * 60 * 24 });

    if (res) {
      // If a response object was passed, set up the cookies
      // for authentication and CSRF
      res.cookie('JWT-TOKEN', token);
      res.cookie('XSRF-TOKEN', payload.csrfToken);
    }

    return token;
  };

  var processJWTToken = function(req, res, next) {
    var authorizationHeader = req.headers.authorization;
    if (! authorizationHeader) { return next(); }

    var jwtToken = authorizationHeader.split(' ')[1];
    if (! jwtToken) { return res.status(403).send("Invalid authorization header"); }

    var payload = null;
    try {
      payload = jwt.verify(jwtToken, config.secrets.jwtSecret);
    } catch(ex) {
      return res.status(403).send(ex.message);
    }
    if (! payload) { return res.status(403).send("Invalid JWT payload"); }
    if (! payload.userId) { return res.status(403).send("No userId in JWT payload"); }

    // Put the CSRF token in the request
    req.__csrfToken = payload.csrfToken;

    User.findById(payload.userId).exec().
      then(function(user) {
        if (! user) { return res.status(403).send("Unknown user"); }
        req.current_user = user;
        next();
      }).
      catch(next);

  };

  var verifyAuthenticated = function(req, res, next) {
    if (req.current_user) {
      return next();
    }

    res.status(403).send('You are not permitted to perform this action.');
  };

  var verifyRequest = function(req, res, next) {
    var csrfToken = req.headers["x-xsrf-token"];

    if (! csrfToken || csrfToken !== req.__csrfToken) {
      return res.status(403).send('You are not permitted to perform this action.');
    }
    next();
  };

  var mod = {
    createJWTToken: createJWTToken,
    processJWTToken: processJWTToken,
    verifyAuthenticated: verifyAuthenticated,
    verifyRequest: verifyRequest
  };

  return mod;
}());
