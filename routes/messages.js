var express = require('express');
var router = express.Router();

/**
 * POST /messages
 *
 * Submits a message to WebSockets for the client to receive.
 *
 * Just a test action
 */
router.post('/', (req, res, next) => {
  console.log("Received the message from the FE");
  socketIO.sockets.emit('user:logged_out', { msg: 'joyful dog' });
  console.log("Broadcast the message");
  res.json({ status: 'sent' });
});

module.exports = router;
