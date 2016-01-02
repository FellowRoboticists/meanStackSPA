var express = require('express');
var router = express.Router();
var multer = require('multer');
var upload = multer({ dest: '/tmp' });

/**
 * GET /documents -
 *
 * Retrieves the list of all documents in the system.
 *
 * Caller must be authenticated.
 */
router.get('/', 
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           (req, res, next) => {

  Document.find({}).
    exec().
    then( (documents) => res.json(documents) );
});

/**
 * Define an URL parameter to be used in this router to identify
 * a document ID (e.g. /documents/:document).
 *
 * If valid, sets the document on the request (e.g. req.document = document).
 */
router.param('document', (req, res, next, id) => {
  Document.findById(id).
    exec().
    then((document) => {
      if (! document) { return next(new Error("Unable to find document")); }
      req.document = document
      next();
    }).
    catch(next);
});

/**
 * POST /documents/:document
 *
 * Retrieves a token that can be used to perform the actual download of the 
 * document.
 *
 * Caller must be authenticated. Pay no attention to the commented out
 * middle-ware; when we have this worked out in the front-end, these
 * will be uncommented.
 */
router.post('/:document',
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           (req, res, next) => {

  res.json({ 
    token: authentication.buildDownloadToken(req.originalUrl) 
  });
});

/**
 * GET /documents/:document
 *
 * Downloads the requested document.
 *
 * Caller must provide a query parameter of 'token' with a value that
 * is the token provided by the POST /documents/:document request. This
 * takes care of authentication.
 */
router.get('/:document',
           authentication.verifyDownloadToken,
           (req, res, next) => {

  grid.downloadFromGridFS(req.document._id.toString(), 'documents').
    then( (data) => {
      res.contentType('application/pdf; name="' + req.document.name + '"');
      res.attachment(req.document.name);
      res.send(new Buffer(data));
    }).
    catch( next );
});

/**
 * POST /documents
 *
 * Handles a file upload from the client.
 *
 * Caller must be authenticated.
 */
router.post('/',
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           upload.array('documentFile', 1),
           (req, res, next) => {

  if (req.files.length > 0) {
    // There's a file upload here. Let's do this thing.
    var fileToUpload = req.files[0];
    var document = new Document({
                               name: fileToUpload.originalname
    });
    // document.name = fileToUpload.originalname;
    document.save().
      then( (document) => grid.writeToGridFS(document._id.toString(), fileToUpload.path, 'documents').
            then( () => document ) ).
      then( (u) => res.json(u) ).
      catch( (err) => console.log(err.stack) );
  } else {
    // No file upload
    res.json({msg: "You didn't put in a file, dipstick"});
  }
});

/**
 * DELETE /documents/:document
 *
 * Removes the document and the file from the system.
 *
 * The user must be authenticated.
 */
router.delete('/:document',
           authentication.processJWTToken,
           authentication.verifyAuthenticated,
           (req, res, next) => {
             
  grid.removeGridFSFile(req.document._id.toString(), 'documents').
    then( () => Document.remove({ _id: req.document._id }).
         then( (document) => res.json(req.user) ) ).
    catch( next );
});

module.exports = router;
