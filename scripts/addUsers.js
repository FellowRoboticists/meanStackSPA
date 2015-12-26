#!/usr/bin/env node

var mongoose = require('mongoose');
mongoose.Promise = global.Promise;

var User = require('../models/User');

mongoose.connect("mongodb://localhost/meanStackSPA");

var conn = mongoose.connection;
conn.on('error', console.error.bind(console, 'connection error: '));
conn.once('open', function() {

  var user = new User({
    name: "user1",
    email: "user1@mail.com",
    password: "Pass1234",
    permissions: {
      manageUsers: true,
    },
    locked: false
  });

  user.save().
    then(function(u) {
      console.log(`Saved new user: ${u}`);
      process.exit();
    }).
    catch(function(err) {
      console.log(err.stack);
    });
});
