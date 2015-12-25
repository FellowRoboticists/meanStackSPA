var gulp  = require( "gulp");
var shell = require( "gulp-shell" );

gulp.task( "linkProd", ["unlink"], function(){
  return gulp.src("")
    .pipe( shell(["gulpfile.js/scripts/linkProd.sh"]) );
});
