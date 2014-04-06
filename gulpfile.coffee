gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
mocha = require 'gulp-mocha'
config = require './config'

gulp.task 'coffee', ()->
  gulp
    .src config.coffee.src
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest config.coffee.dest

gulp.task 'test', ()->
  gulp
    .src config.test.src
    .pipe mocha {reporter: 'spec'}

gulp.task 'default', ['coffee']
