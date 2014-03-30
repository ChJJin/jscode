gulp = require 'gulp'
coffee = require 'gulp-coffee'
config = require './config'

gulp.task 'coffee', ()->
	gulp
		.src config.coffee.src
		.pipe coffee()
		.pipe gulp.dest config.coffee.dest

gulp.task 'default', ['coffee']
