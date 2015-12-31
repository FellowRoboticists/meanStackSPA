var express = require('express');
var router = express.Router();
var multer = require('multer');
var upload = multer({ dest: '/tmp' });

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
           upload.array('documentFile', 1),
           function(req, res, next) {

  if (req.files.length > 0) {
    // There's a file upload here. Let's do this thing.
    var fileToUpload = req.files[0];
    var document = new Document();
    document.name = fileToUpload.originalname;
    document.save().
      then((u) => {
        return grid.writeToGridFS(u._id.toString(), fileToUpload.path, 'documents').
          then( () => u );
      }).
      then( (u) => res.json(u) ).
      catch( (err) => console.log(err.stack) );
  } else {
    // No file upload
    res.json({msg: "You didn't put in a file, dipstick"});
  }
});

module.exports = router;
