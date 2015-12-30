var express = require('express');
var router = express.Router();

console.log("Value of authentication: %j", authentication);
console.log("Value of processJWTToken: " + typeof authentication.processJWTToken);
console.log("Value of verifyAuthenticated: " + typeof authentication.verifyAuthenticated);

router.get('/', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           function(req, res, next) {
  Document.find({}).exec().
    then(function(documents) { res.json(documents); } );
});

router.post('/',
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           function(req, res, next) {

  if (req.files.documentFile) {
    // There's a file upload here. Let's do this thing.
    var document = new Document();
    document.name = req.files.documentFile.name;
    user.save().
      then((u) => {
        return grid.writeToGridFS(u._id.toString(), req.files.documentFile.path, 'documents').
          then( () => u );
      }).
      then( (u) => res.json(u) );
  } else {
    // No file upload
    res.json({msg: "You didn't put in a file, dipstick"});
  }
});

module.exports = router;
