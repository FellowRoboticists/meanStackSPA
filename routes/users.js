var express = require('express');
var router = express.Router();

/**
 * GET /users
 *
 * Returns the list of users in the system.
 *
 * Caller must be authenticated.
 */
router.get('/', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           (req, res, next) => {

  User.find({}).exec().
    then( (users) => res.json(users) );
});

/**
 * Handles the user id param passed in some URI's.
 *
 * Sets the 'user' variable on the req object.
 */
router.param('user', (req, res, next, id) => {

  User.findById(id).exec().
    then( (user) => {
      if (! user) { return next(new Error("Unable to find user")); }
      req.user = user;
      next();
    }).
    catch(next);
});

/**
 * GET /users/:user
 *
 * Returns the data for the specified user.
 *
 * Caller must be authenticated.
 */
router.get('/:user', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           (req, res, next) => {

  res.json(req.user);
});

/**
 * POST /users
 *
 * Creates a new user in the system.
 *
 * Returns the list of users after the new user was added.
 *
 * Caller must be authenticated.
 */
router.post('/', 
            authentication.processJWTToken,
            authentication.verifyAuthenticated,
            authentication.verifyRequest,
            (req, res, next) => {

  var user = new User(req.body);
  user.
    save().
    then( (u) => User.
         find().
         exec().
         then( (users) => res.json(users) ) 
    );
});

/**
 * PUT /users/:user
 *
 * Update the specified user.
 *
 * Returns the updated user.
 *
 * Caller must be authenticated.
 */
router.put('/:user', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           authentication.verifyRequest,
           (req, res, next) => {

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
    then( (user) => res.json(user) ).
    catch( (err) => {
      console.log(err.stack);
      res.status(500).send(err.message);
    });
});

/**
 * DELETE /users/:user
 *
 * Deletes the specified user.
 *
 * Returns the deleted user.
 *
 * Caller must be authenticated.
 */
router.delete('/:user', 
              authentication.processJWTToken,
              authentication.verifyAuthenticated,
              authentication.verifyRequest,
              (req, res, next) => {

  User.remove({ _id: req.user._id }).
    then( (u) => res.json(req.user) );
});

module.exports = router;
