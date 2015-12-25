var gulp = require( "gulp" );
var flatten = require( "gulp-flatten" );

gulp.task( "images", function(cb){
  return gulp.src( ["./src/**/*.{png,gif,jpg,svg}"] )
    .pipe( flatten() )
    .pipe( gulp.dest( "./dist/images" ) )
});
