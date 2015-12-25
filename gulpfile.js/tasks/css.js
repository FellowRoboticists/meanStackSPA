var config = require( "../config.json" );
var gulp = require( "gulp" );
var eventStream = require( "event-stream" );
var concat = require( "gulp-concat" );
var sass = require( "gulp-sass" );
var changed = require( "gulp-changed" );
var stripComments = require( "gulp-strip-comments" );

gulp.task( "css", function(cb){

  // Init vendor css stream
  function _vendor_css(){
    return gulp.src( config.vendor_css_src )
      .pipe( stripComments() )
  }

  // Init app sass stream
  function _app_sass(){
    return gulp.src( ["./src/**/*.scss"] )
      .pipe( sass({errLogToConsole: true}) )
  }

  // Join vendor/app css streams
  return eventStream.merge( _vendor_css(), _app_sass() )
    .pipe( changed( "./dist/css" ) )
    .pipe( concat( "styles.css" ) )
    .pipe( gulp.dest( "./dist/css" ) )

});