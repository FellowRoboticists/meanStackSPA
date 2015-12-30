module.exports = (function() {

  var mongoose = require('mongoose');
  var Grid = require('gridfs-stream');
  var fs = require('fs');

  // var Grid.mongo = mongoose.mongo;

  var writeToGridFS = (filename, pathToStore, root) => {
    var gfs = Grid(mongoose.connection.db, mongoose.mongo);
    return new Promise(function(resolve, reject) {
      var writeStream = gfs.createWriteStream({
        filename: filename,
        content_type: 'application/pdf',
        chunkSize: 2048,
        root: root
      });

      fs.createReadStream(pathToStore).pipe(writeStream);

      writeStream.on('error', function(err) { reject(err); });
      writeStream.on('finish', function() { resolve(); } );
    });
  };

  var mod = {
    writeToGridFS: writeToGridFS
  };

  return mod;
}());
