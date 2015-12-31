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

router.param('document', function(req, res, next, id) {
  Document.findById(id).exec().
    then(function(document) {
      if (! document) { return next(new Error("Unable to find document")); }
      req.document = document
      next();
    }).
    catch(next);
});

router.get('/:document',
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           function(req, res, next) {
  // Use the _id of the document as the name of the file
  // to retrieve from GridFS
  next();
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

router.delete('/:document'
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           function(req, res, next) {
  // First, delete the grid FS file associated with the document
  // Now, remove the actual document from the database
  Document.remove({ _id: req.document._id }).
    then( (document) => res.json(req.user) );
  next();
});

module.exports = router;
