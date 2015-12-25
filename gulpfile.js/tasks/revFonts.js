var gulp = require( "gulp" );
var runSequence = require( "run-sequence" );
var revCollector = require( "gulp-rev-collector" );
var rev = require( "gulp-rev" );
var q = require( "q" );

gulp.task( "revFonts", function(){

  var deferred = q.defer();

  gulp.task("_rev_fonts", function(){
    return gulp.src( ["./dist/fonts/*.woff"] )
      .pipe( rev() )
      .pipe( gulp.dest( "./prod/fonts" ) )
      .pipe( rev.manifest( "fonts.json" ) )
      .pipe( gulp.dest( "./dist/rev" ) );
  });

  gulp.task("_rev_fontUrls", function(){
    return gulp.src( ["./dist/rev/fonts.json", "./prod/css/styles-*.css"] )
      .pipe( revCollector() )
      .pipe( gulp.dest( "./prod/css" ) )
      .on("end", function(){
        deferred.resolve();
      });
  });

  runSequence( "_rev_fonts", "_rev_fontUrls" );

  return deferred.promise;
})
