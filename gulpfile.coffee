gulp = require 'gulp'
g    = require('gulp-load-plugins')()
config = 
  coffee:
    src: "./src/coffee/**/*.coffee"
    dest: "./src/js"
  test:
    src: "./test/*"

gulp.task 'coffee', ()->
  gulp
    .src config.coffee.src
    .pipe g.coffee().on 'error', g.util.log
    .pipe gulp.dest config.coffee.dest

gulp.task 'test', ()->
  gulp
    .src config.test.src
    .pipe g.mocha {reporter: 'spec'}

gulp.task 'default', ['coffee']
