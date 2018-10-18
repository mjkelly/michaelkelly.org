const gulp = require('gulp');
const cleanCSS = require('gulp-clean-css');
const del = require('del');
const htmlmin = require('gulp-htmlmin');

gulp.task('minify-css', () => {
  return gulp.src('www/*.css')
    .pipe(cleanCSS({compatibility: 'ie8'}))
    .pipe(gulp.dest('dist'));
});

gulp.task('copy-assets', () => {
  return gulp.src('www/assets/**')
    .pipe(gulp.dest('dist/assets'));
});

gulp.task('minify-html', () => {
  return gulp.src('www/index.html')
    .pipe(htmlmin({ collapseWhitespace: true }))
    .pipe(gulp.dest('dist'));
});

gulp.task('copy-js', () => {
  return gulp.src('www/*.js')
    .pipe(gulp.dest('dist'));
});

gulp.task('clean', () => {
  return del(['dist']);
});

gulp.task('build', ['copy-assets', 'minify-html', 'minify-css', 'copy-js']);
