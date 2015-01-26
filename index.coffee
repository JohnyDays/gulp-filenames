through = require("through2")
gutil = require("gulp-util")

# gulp-filenames
# Register every filename that has passed through
# Options:
# * name
# * options
# * options.overrideMode
# * override previous files when a new one passes through
file_names = {}

module.exports = (name, options = {}) ->

  filenames = (file, enc, done) ->

    # Do nothing if no contents
    if file.isNull()
      @push file

    # Error if file is a stream
    if file.isStream()
      @emit "error", new gutil.PluginError("gulp-filenames", "Stream content is not supported")

    if file.isBuffer()
      module.exports.register(file, name, options)
      @push file

    done(null, file)

  through.obj filenames

# Retrieve a specific hash of filenames. 'all' to get everything.
# You can also retrieve 'relative', 'base', 'full' or 'all' of the file name.
# Default is an array of relative paths.

module.exports.get = (name='default', what='relative') ->
  return file_names if name is 'all'
  switch what
    when 'relative'
      file_names[name] ?= []
      (file_name.relative for file_name in file_names[name])
    when 'full'
      file_names[name] ?= []
      (file_name.full for file_name in file_names[name])
    when 'base'
      file_names[name] ?= []
      (file_name.base for file_name in file_names[name])
    when 'all'
      file_names[name] ?= []
      file_names[name]
    else (file_name.relative for file_name in file_names[name])

# Remove a specific filename hash. 'all' to empty everything
module.exports.forget = (name='default')->
  file_names = {} if name is 'all'
  file_names[name] = {}

# Register a file name/path in a namespaced array
module.exports.register = (file, name = "default", options)->

  if options.overrideMode
    file_names[name] = []
  else
    file_names[name] ?= []

  file_names[name].push
    relative: file.relative
    full: file.path
    base: file.base
