#!/usr/bin/env node

const jwt = require('jsonwebtoken');
const fs = require('fs');

// First, load up the private key from the filesystem
const cert = fs.readFileSync('/home/dsieh/.ssh/id_rsa');

const payload = {
  name: "minion",
  age: 2
};

const token = jwt.sign(payload, cert, { algorithm: 'RS512' });

console.log("The token we created: %j", token);

// Now, try to verify it and get the token out
// The public key below isn't checked in to the repository, so you'll have to
// recreate it using; ssh-keygen -f ~/.ssh/id_rsa.pub -e -m pem > id_rsa.pub.pem
const pub = fs.readFileSync('id_rsa.pub.pem');
console.log("Public Key: %j", pub);

jwt.verify(token, pub, (err, decoded) => {
  console.log("The payload: %j", decoded);
  if (err) { return console.error("Error verifying the token: %j", err) }
});
