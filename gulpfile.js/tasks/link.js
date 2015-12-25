var gulp  = require( "gulp");
var shell = require( "gulp-shell" );

gulp.task( "link", ["unlink"], function(){
  return gulp.src("")
    .pipe( shell(["gulpfile.js/scripts/link.sh"]) );
});
