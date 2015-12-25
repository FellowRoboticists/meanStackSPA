var gulp = require( "gulp" );
var del = require( "del" );

gulp.task( "cleanProd", function(cb){
  return del( ["./prod/*"], cb );
})