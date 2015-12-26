var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');

var UserSchema = new Schema({

  name: {
    type: String
  },

  email: {
    type: String
  },

  password: {
    type: String
  },

  locked: {
    type: Boolean,
    default: false
  },

  permissions: {
    type: Schema.Types.Mixed
  },

  createdAt: {
    type: Date
  },

  updatedAt: {
    type: Date
  }

}, { collection: 'user' });

// Deal with the toJSON transformation
UserSchema.options.toJSON = {

  transform: function(doc, ret, options) {
    ret.id = ret._id;
    delete ret.__v;
    delete ret.password;
    delete ret.createdAt;
    delete ret.updatedAt;
    delete ret._id;

    return ret;
  }
  
};

// Add some middleware

// Deal with the createdAt and updatedAt fields
UserSchema.pre('save', function(next) {
  this.updatedAt = new Date();
  if (! this.createdAt) {
    this.createdAt = this.updatedAt;
  }
  next();
});

// Encrypt the user's password
UserSchema.pre('save', function(next) {
  var user = this;

  // only hash the password if it has been modified (or is new)
  if (! user.isModified('password')) {
    return next();
  }

  bcrypt.hash(user.password, 10, function(err, encryptedPassword) {
    if (err) { return next(err); }
    user.password = encryptedPassword;
    next();
  });
});


// Now add some methods
UserSchema.methods.comparePassword = function(password, cb) {
  bcrypt.compare(password, this.password, function(err, valid) {
    if (err) { return cb(err); }
    cb(null, valid);
  });
};

// return mongoose.model('User', userSchema);
module.exports = mongoose.model('User', UserSchema);

