var gulp = require( "gulp" );

gulp.task( "copyIndexProd", function(cb){
  return gulp.src( "./dist/index.html" )
    .pipe( gulp.dest( "./prod" ) )
});
