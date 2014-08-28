
# gulp-filenames
[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url]  [![Coverage Status][coveralls-image]][coveralls-url] [![Dependency Status][depstat-image]][depstat-url]

> Filename gathering plugin for [gulp](https://github.com/wearefractal/gulp)

## Usage

First, install `gulp-filenames` as a development dependency:

```shell
npm install --save-dev gulp-filenames
```

Then, add it to your `gulpfile.js`:

```javascript
var filenames = require("gulp-filenames");

gulp.src("./src/*.coffee")
	.pipe(filenames("coffeescript"))
	.pipe(gulp.dest("./dist"));

gulp.src("./src/*.js")
  .pipe(filenames("javascript"))
  .pipe(gulp.dest("./dist"));

filenames.get("coffeescript") // ["a.coffee","b.coffee"] 
                              // Do Something With it
```

## API

### filenames([name])

#### name

Namespace the filenames

### filenames.get([name], [what])

#### name 
Get only these filenames ("all" to get everything)

#### what

"relative" or "full" or "path" for an array of filenames

"all" for an array of objects

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)

[npm-url]: https://npmjs.org/package/gulp-filenames
[npm-image]: https://badge.fury.io/js/gulp-filenames.png

[travis-url]: http://travis-ci.org/JohnyDays/gulp-filenames
[travis-image]: https://secure.travis-ci.org/JohnyDays/gulp-filenames.png?branch=master

[coveralls-url]: https://coveralls.io/r/JohnyDays/gulp-filenames
[coveralls-image]: https://coveralls.io/repos/JohnyDays/gulp-filenames/badge.png

[depstat-url]: https://david-dm.org/JohnyDays/gulp-filenames
[depstat-image]: https://david-dm.org/JohnyDays/gulp-filenames.png
