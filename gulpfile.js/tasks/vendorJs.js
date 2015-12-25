var config = require( "../config.json" );
var gulp = require( "gulp" );
var changed = require( "gulp-changed" );
var ngAnnotate = require( "gulp-ng-annotate" );
var concat = require( "gulp-concat" );
var stripComments = require( "gulp-strip-comments" );

gulp.task( "vendorJs", function(cb){

  return gulp.src( config.vendor_js_src )
    .pipe( changed( "./dist/js" ) )
    .pipe( concat( "vendor.js" ) )
    .pipe( stripComments({line:true}) )
    .pipe( ngAnnotate() )
    .pipe( gulp.dest( "./dist/js" ) )
});