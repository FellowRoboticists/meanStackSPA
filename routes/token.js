var express = require('express');
var router = express.Router();
var authentication = require('../services/authentication');

// Set up the JWT token for authentication
router.post('/', function(req, res, next) {
  console.log(`Email: ${req.body.email}`);
  console.log(`Password: ${req.body.password}`);
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

  // At this point we're not really checking the for authentication.
  // Just let it go.
  //res.json({ 
    //user: { 
      //name: 'Jimmy',
      //email: 'test@mail.com',
      //permissions: {
        //manageUsers: true
      //}
    //} 
  //});
});

router.delete('/', function(req, res, next) {
  // We have nothing really to do on logout...
  res.json({});
});


module.exports = router;
