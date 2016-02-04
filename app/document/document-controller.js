const express = require('express');
const router = express.Router();
const multer = require('multer');
const upload = multer({ dest: '/tmp' });

const Document = require('./document-model');
const tokenMW = require('../token/token-middleware');
const gridSVC = require('../utility/grid-service');

/**
 * GET /documents -
 *
 * Retrieves the list of all documents in the system.
 *
 * Caller must be authenticated.
 */
router.get('/', 
           tokenMW.processJWTToken,
           tokenMW.verifyAuthenticated,
           (req, res, next) => {

  Document.find({}).
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
    then((document) => {
      if (! document) { return next(new Error("Unable to find document")); }
      req.document = document
      next();
    }).
    catch(next);
});

/**
 * GET /documents/:document
 *
 * Downloads the requested document.
 *
 * Caller must provide a query parameter of 'token' with a value that
 * is the token provided by the POST /documents/:document request. This
 * takes care of tokenMW.
 */
router.get('/:document',
           tokenMW.processJWTToken,
           tokenMW.handleResourceAccess,
           tokenMW.verifyDownloadToken,
           (req, res, next) => {

  gridSVC.downloadFromGridFS(req.document._id.toString(), 'documents').
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
           tokenMW.processJWTToken,
           tokenMW.verifyAuthenticated,
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
      then( (document) => gridSVC.writeToGridFS(document._id.toString(), fileToUpload.path, 'documents').
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
           tokenMW.processJWTToken,
           tokenMW.verifyAuthenticated,
           (req, res, next) => {
             
  gridSVC.removeGridFSFile(req.document._id.toString(), 'documents').
    then( () => Document.remove({ _id: req.document._id }).
         then( (document) => res.json(req.user) ) ).
    catch( next );
});

module.exports = router;
