const express = require('express');
const router = express.Router();

const queueSVC = require('../utility/queue-service');

/**
 * POST /messages
 *
 * Submits a message to WebSockets for the client to receive.
 *
 * Just a test action
 */
router.post('/', (req, res, next) => {
  // socketIO.sockets.emit('user:logged_out', { msg: 'joyful dog' });
  queueSVC.queueJob('talker', 'messageQueue', 100, 0, 300, 'joyful dog').
    then( () => res.json({ status: 'sent' }) ).
    catch(next);
});

module.exports = router;
