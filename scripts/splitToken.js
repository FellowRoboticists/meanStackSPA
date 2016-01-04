#!/usr/bin/env node

var jwt = require('jsonwebtoken');

var payload = {
  user_id: 1234,
  csrf_token: 'abcdefghijklmnopqrstuvwxyz'
};

var token = jwt.sign(payload, 'this is my secret', { expiresIn: 60 * 60 * 24 });

console.log("The token: %j", token);

var payload = jwt.decode(token, { complete: true });

console.log("The decoded payload: %j", payload);
