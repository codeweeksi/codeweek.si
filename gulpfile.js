var gulp =  require('gulp'),
  deporder = require('gulp-deporder'),
  concat = require('gulp-concat'),
  uglify = require('gulp-uglify'),
  pump = require('pump'),
  rename = require('gulp-rename'),
  del = require('del'),
  sass = require('gulp-sass'),
  merge = require('merge-stream'),
  
  // folders
  folder = {
    src: '_src/',
    dest: 'assets/'
  };

// Scripts
gulp.task('scripts', function (cb) {
  pump([
      gulp.src([
        folder.src + 'lib/jquery/*.js',
        folder.src + 'lib/bootstrap/*.js',
        folder.src + 'lib/countdown/jquery.plugin.js',
        folder.src + 'lib/countdown/jquery.countdown.js',
        folder.src + 'lib/countdown/jquery.countdown-sl.js',
        folder.src + 'lib/easing/*.js',
        folder.src + 'lib/magnific-popup/*.js',
        folder.src + 'lib/scrollreveal/*.js',
        folder.src + 'js/**/*.js'
        ]),
      deporder(),
      concat('scripts.js'),
      uglify(),
      rename(function (path) {
                      if(path.extname === '.js') {
                          path.basename += '.min';
                      }
                  }),
      gulp.dest(folder.dest + 'js/')
    ],
    cb
    );
  });


// Styles
gulp.task('sass', function(cb) {
  pump([
      gulp.src([folder.src + 'sass/*.scss']),
      sass(),
      concat('style.css'),
      //rename(function (path) {
      //                if(path.extname === '.css') {
      //                    path.basename += '.min';
      //                }
      //            }),
      gulp.dest(folder.dest + 'css/')
    ],
    cb
    );
});


//Images
gulp.task('images', function() {
  var out = folder.dest + 'img/';
  
  return gulp.src(folder.src + 'img/**/*')
        .pipe(gulp.dest(out));
});

//Fonts
gulp.task('fonts', function() {
  var out = folder.dest + 'fonts/';
  
  return gulp.src(folder.src + 'fonts/**/*')
        .pipe(gulp.dest(out));
});


// Clean
gulp.task('clean', function() {
    return del([
      'assets/css/**/*', 'assets/js/**/*'
      ]);
});


gulp.task('default', ['scripts', 'sass', 'images', 'fonts'], function() {
  console.log("Default task");
});