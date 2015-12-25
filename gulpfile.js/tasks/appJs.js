var gulp = require( "gulp" );
var eventStream = require( "event-stream" );
var concat = require( "gulp-concat" );
var changed = require( "gulp-changed" );
var flatten = require( "gulp-flatten" );
var minifyHtml = require( "gulp-minify-html" );
var angularTemplatecache = require( "gulp-angular-templatecache" );
var coffee = require( "gulp-coffee" );
var ngAnnotate = require( "gulp-ng-annotate" );

gulp.task( "appJs", function(cb){

  function _templates(){
    return gulp.src( ["./src/**/*.html"] )
      .pipe( flatten() )
      .pipe( minifyHtml() )
      .pipe( angularTemplatecache() )
  }

  function _coffeescript(){
    return gulp.src( ["./src/**/*module.coffee", "./src/**/*.coffee"] )
      .pipe( coffee() )
      .pipe( ngAnnotate() )
  }

  return eventStream.merge( _templates(), _coffeescript() )
    .pipe( changed( "./dist/js" ) )
    .pipe( concat( "app.js" ) )
    .pipe( gulp.dest( "./dist/js" ) )

});