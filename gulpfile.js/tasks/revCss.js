var gulp = require( "gulp" );
var runSequence = require( "run-sequence" );
var revCollector = require( "gulp-rev-collector" );
var minifyCss = require( "gulp-minify-css" );
var rev = require( "gulp-rev" );
var q = require( "q" );
var concat = require( "gulp-concat" );

gulp.task( "revCss", function(cb){

  var deferred = q.defer();

  gulp.task("_rev_css", function(){
    return gulp.src( ["./dist/css/styles.css"] )
      .pipe( minifyCss() )
      .pipe( rev() )
      .pipe( gulp.dest( "./prod/css" ) )
      .pipe( rev.manifest( "styles.json" ) )
      .pipe( gulp.dest( "./dist/rev" ) );
  });

  gulp.task("_rev_cssUrls", function(){
    return gulp.src( ["./dist/rev/styles.json","./prod/index.html"] )
      .pipe( revCollector() )
      .pipe( gulp.dest( "./prod/" ) )
      .on("end", function(){
        deferred.resolve();
      });
  });

  runSequence( "_rev_css", "_rev_cssUrls" );

  return deferred.promise;

});
