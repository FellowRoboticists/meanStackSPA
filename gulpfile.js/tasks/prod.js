var gulp = require('gulp');
var runSequence = require("run-sequence");

gulp.task( "prod", ["default"], function(cb){
  return runSequence(
    "cleanProd",
    "copyIndexProd",
    "revCss",
    "revJs",
    "revImages",
    "revFonts",
    "linkProd",
    cb
  );
});