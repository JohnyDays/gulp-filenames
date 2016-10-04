# global describe, it

fs        = require "fs"
es        = require "event-stream"
should    = require "should"
mocha     = require "mocha"

gulp      = require "gulp"
source    = require('vinyl-source-stream');
filenames = require "../"

describe "gulp-filenames", ->

	before () ->
	   	filenames.forget("all")

	it "Should grab the name of every file that passes through it", (done)->

		gulp.src("./test/files/**/*")
			.pipe filenames()
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				all_files = filenames.get()
				all_files.should.eql ["a.cc", "a.empty", "a.txt","b.txt"]
				done()


	it "Supports namespacing", (done)->

		gulp.src("./test/files/*.txt")
			.pipe filenames("txt")
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				txt_files = filenames.get("txt")
				txt_files.should.eql ["a.txt", "b.txt"]
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


	it "Supports empty files", (done)->

		gulp.src("./test/files/*.empty")
			.pipe filenames("empty")
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				empty_files = filenames.get("empty")
				empty_files.should.eql ["a.empty"]
				done()


	it "Should not allow the 'all' namespace", (done)->

		try
			gulp.src("./test/files/**.*")
				.pipe filenames("all")
				.pipe gulp.dest("./test/dump")
				.on "end", ->
					thrown_files = filenames.get("throw")
					thrown_files.should.be.empty
					done()
		catch e
		     e.should.equal("'all' is a reserved namespace")
			 done()


	it "Should allow the 'default' namespace", (done)->

		gulp.src("./test/files/**.*")
			.pipe filenames("default")
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				default_files = filenames.get("default")
				default_files.should.eql ["a.cc", "a.empty", "a.txt", "b.txt"]
				done()


	it "Works with streams", (done)->

		fs.createReadStream('./test/files/a.txt')
			.pipe source("a.txt")
			.pipe filenames("streams")
			.pipe gulp.dest("./test/dump")
			.on "end", ->
				all_files = filenames.get("streams")
				all_files.should.eql ["a.txt"]
				done()
