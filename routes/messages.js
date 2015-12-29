var express = require('express');
var router = express.Router();

router.post('/', function(req, res, next) {
  console.log("Received the message from the FE");
  socketIO.sockets.emit('user:logged_out', { msg: 'joyful dog' });
  console.log("Broadcast the message");
  res.json({ status: 'sent' });
});

module.exports = router;
