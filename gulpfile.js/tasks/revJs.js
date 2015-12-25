var gulp = require( "gulp" );
var runSequence = require( "run-sequence" );
var revCollector = require( "gulp-rev-collector" );
var rev = require( "gulp-rev" );
var q = require( "q" );
var uglify = require( "gulp-uglify" );

gulp.task( "revJs", function(cb){

  var deferred = q.defer();

  gulp.task("_rev_js", function(){
    return gulp.src( ["./dist/js/*.js"] )
      .pipe( uglify() )
      .pipe( rev() )
      .pipe( gulp.dest( "./prod/js" ) )
      .pipe( rev.manifest( "scripts.json" ) )
      .pipe( gulp.dest( "./dist/rev" ) );
  });

  gulp.task("_rev_jsUrls", function(){
    return gulp.src( ["./dist/rev/scripts.json","./prod/index.html"] )
      .pipe( revCollector() )
      .pipe( gulp.dest( "./prod/" ) )
      .on("end", function(){
        deferred.resolve();
      });
  });

  runSequence( "_rev_js", "_rev_jsUrls" );

  return deferred.promise;

});
