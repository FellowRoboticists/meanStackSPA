var gulp = require( "gulp" );

gulp.task( "copyIndex", function(cb){
  return gulp.src( "./src/index.html" )
    .pipe( gulp.dest( "./dist" ) )
});
