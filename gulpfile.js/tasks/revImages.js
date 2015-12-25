var gulp = require( "gulp" );
var runSequence = require( "run-sequence" );
var revCollector = require( "gulp-rev-collector" );
var rev = require( "gulp-rev" );
var q = require( "q" );

gulp.task( "revImages", function(){

  var deferred = q.defer();

  gulp.task("_rev_images", function(){
    return gulp.src( ["./dist/images/*.{png,gif,jpg,svg}"] )
      .pipe( rev() )
      .pipe( gulp.dest( "./prod/images" ) )
      .pipe( rev.manifest( "images.json" ) )
      .pipe( gulp.dest( "./dist/rev" ) );
  });

  gulp.task("_rev_imageUrls", function(){
    return gulp.src( ["./dist/rev/images.json", "./prod/css/styles-*.css"] )
      .pipe( revCollector() )
      .pipe( gulp.dest( "./prod/css" ) )
      .on("end", function(){
        deferred.resolve();
      });
  });

  runSequence( "_rev_images", "_rev_imageUrls" );

  return deferred.promise;
});
