var express = require('express');
var router = express.Router();

// Set up the JWT token for authentication
router.post('/', function(req, res, next) {
  console.log(`Email: ${req.body.email}`);
  console.log(`Password: ${req.body.password}`);

  // At this point we're not really checking the for authentication.
  // Just let it go.
  res.json({ 
    user: { 
      name: 'Jimmy',
      email: 'test@mail.com',
      permissions: {
        manageUsers: true
      }
    } 
  });
});

router.delete('/', function(req, res, next) {
  // We have nothing really to do on logout...
  res.json({});
});


module.exports = router;
