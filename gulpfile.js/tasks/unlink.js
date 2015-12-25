var gulp  = require( "gulp");
var shell = require( "gulp-shell" );

gulp.task( "unlink", function(){
  return gulp.src("")
    .pipe( shell(["gulpfile.js/scripts/unlink.sh"]) );
});
