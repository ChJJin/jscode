gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
config = require './config'

gulp.task 'coffee', ()->
  gulp
    .src config.coffee.src
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest config.coffee.dest

gulp.task 'default', ['coffee']
