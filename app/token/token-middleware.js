module.exports = (() => {

  const mongoose = require('mongoose');
  const jwt = require('jsonwebtoken');

  const User = require('../user/user-model');

  const createJWTToken = (user, res) => {
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

  const buildDownloadToken = (uri) => {
    var payload = {
      url: uri
    };

    // Expires in 5 minutes
    return jwt.sign(payload, config.secrets.jwtSecret, { expiresIn: 60 * 5 });
  };

  const verifyDownloadToken = (req, res, next) => {
    var thisUrl = req.originalUrl;
    thisUrl = thisUrl.substring(0, thisUrl.indexOf('?'));

    var jwtToken = req.query.token;
    if (! jwtToken) { return res.status(403).send("No token provided") }
    try {
      payload = jwt.verify(jwtToken, config.secrets.jwtSecret);
    } catch(ex) {
      return res.status(403).send(ex.message);
    }

    if (thisUrl === payload.url) {
      next();
    } else {
      res.status(403).send("URL's didn't match...");
    }
  };

  const processJWTToken = (req, res, next) => {
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

    User.findById(payload.userId).
      then( (user) => {
        if (! user) { return res.status(403).send("Unknown user"); }
        req.current_user = user;
        next();
      }).
      catch(next);

  };

  const handleResourceAccess = (req, res, next) => {
    if (req.current_user) {
      // This means that someone has made a resource acess call.
      // This 'async' request has been authorized, so we need to
      // return a resource token so that a sync request can be made to
      // to actually download the resource...
      res.json({ 
        token: buildDownloadToken(req.originalUrl) 
      });
    } else {
      var jwtToken = req.query.token;
      if (! jwtToken) { return res.status(403).send("No resource token"); }
      next();
    }
  };

  const verifyAuthenticated = (req, res, next) => {
    if (req.current_user) {
      return next();
    }

    res.status(403).send('You are not permitted to perform this action.');
  };

  const verifyRequest = (req, res, next) => {
    var csrfToken = req.headers["x-xsrf-token"];

    if (! csrfToken || csrfToken !== req.__csrfToken) {
      return res.status(403).send('You are not permitted to perform this action.');
    }
    next();
  };

  const mod = {
    createJWTToken: createJWTToken,
    processJWTToken: processJWTToken,
    verifyAuthenticated: verifyAuthenticated,
    verifyRequest: verifyRequest,
    buildDownloadToken: buildDownloadToken,
    verifyDownloadToken: verifyDownloadToken,
    handleResourceAccess: handleResourceAccess
  };

  return mod;
}());
