# global describe, it

fs        = require "fs"
es        = require "event-stream"
should    = require "should"
mocha     = require "mocha"

gulp      = require "gulp"
gutil     = require "gulp-util"
filenames = require "../"

describe "gulp-filenames", ->

	it "Should grab the name of every file that passes through it", (done)->

		gulp.src("./test/files/**/*")
			.pipe filenames()
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				all_files = filenames.get()
				all_files.should.eql ["a.cc","a.txt","b.txt"]
				done()

	it "Supports namespacing", (done)->

		gulp.src("./test/files/*.txt")
			.pipe filenames("txt")
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				txt_files = filenames.get("txt")
				txt_files.should.eql ["a.txt","b.txt"]
				done()

	it "Can retrieve different things using options", ->

		filenames.get("txt", "all"     )[0] .should.be.object
		filenames.get("txt", "relative")[0] .should.be.string

	it "Can forget", ->

		filenames.forget("txt")

		filenames.get("txt").should.be.empty


	it "Support overriding previous file on new one through overrideMode", (done)->

		gulp.src("./test/files/**/*")
			.pipe filenames(null, overrideMode: true)
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				all_files = filenames.get()
				all_files.length.should.eql 1
				done()


