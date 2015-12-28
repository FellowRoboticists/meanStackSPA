var express = require('express');
var router = express.Router();

// Set up the JWT token for authentication
router.post('/', function(req, res, next) {
  User.findOne({email: req.body.email}).exec().
    then(function(user) {
      if (! user) { return res.status(409).send("Invalid credentials"); }
      user.comparePassword(req.body.password, function(err, valid) {
        if (err) { return res.status(409).send("Invalid credentials"); }
        if (! valid) { return res.status(409).send("Invalid credentials"); }
        var obj = {
          user: user
        };
        // Set up the cookies we need for authentication
        authentication.createJWTToken(user, res);
        res.json(obj);
      });
    }).
    catch(function(err) {
      console.log(err.stack);
      res.status(500).send(err.message);
    });
});

router.delete('/', function(req, res, next) {
  // The key thing here is to remove the authentication/CSRF
  // cookies. Basically, this clears the cookie text and sets
  // the expiration to something in the past. This will force
  // the browser to remove these cookies from the domain.
  res.clearCookie('JWT-TOKEN');
  res.clearCookie('XSRF-TOKEN');

  res.json({});
});


module.exports = router;
