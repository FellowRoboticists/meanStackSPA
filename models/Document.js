var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var DocumentSchema = new Schema({

  name: {
    type: String
  },

  createdAt: {
    type: Date
  },

  updatedAt: {
    type: Date
  }

});

DocumentSchema.options.toJSON = {

  transform: function(doc, ret, options) {
    ret.id = ret._id;
    delete ret.__v;
    delete ret.createdAt;
    delete ret.updatedAt;
    delete ret._id;

    return ret;
  }

};

// Add some middleware

// Deal with the createdAt and updatedAt fields
DocumentSchema.pre('save', function(next) {
  this.updatedAt = new Date();
  if (! this.createdAt) {
    this.createdAt = this.updatedAt;
  }
  next();
});

module.exports = mongoose.model('Document', DocumentSchema);
