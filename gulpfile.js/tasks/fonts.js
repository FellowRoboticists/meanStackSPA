var gulp = require( "gulp" );

gulp.task( "fonts", function(cb){
  return gulp.src( "./bower_components/bootstrap/fonts/*.woff" )
    .pipe( gulp.dest( "./dist/fonts" ) )
})
