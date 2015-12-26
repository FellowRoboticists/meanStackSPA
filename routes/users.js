var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  // res.send('respond with a resource');
  res.json([]); // Send an empty array for now..
});

/* Create user */
router.post('/', function(req, res, next) {
  console.log("Create user...%j", req.body);
  res.json([]);
});

module.exports = router;
