var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           function(req, res, next) {
  User.find({}).exec().
    then(function(users) {
      res.json(users);
    });
});

router.param('user', function(req, res, next, id) {
  User.findById(id).exec().
    then(function(user) {
      if (! user) { return next(new Error("Unable to find user")); }
      req.user = user;
      next();
    }).
    catch(next);
});

router.get('/:user', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           function(req, res, next) {
  res.json(req.user);
});

/* Create user */
router.post('/', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           authentication.verifyRequest,
            function(req, res, next) {

  var user = new User(req.body);
  user.save().
    then(function(u) {
      User.find().exec().
        then(function(users) {
          res.json(users);
        });
    });
});

router.put('/:user', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           authentication.verifyRequest,
           function(req, res, next) {
  var user = req.user;

  user.name = req.body.name;
  user.email = req.body.email;
  user.locked = req.body.locked;
  if (req.body.password && req.body.password.length > 0) {
    user.password = req.body.password;
  }
  user.permissions = req.body.permissions;
  user.markModified('permissions');

  user.save().
    then(function(user) {
      res.json(user);
    }).
    catch(function(err) {
      console.log(err.stack);
      res.status(500).send(err.message);
    });
});

router.delete('/:user', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           authentication.verifyRequest,
              function(req, res, next) {
  User.remove({ _id: req.user._id }).
    then(function(u) {
      res.json(req.user);
    });
});

module.exports = router;
