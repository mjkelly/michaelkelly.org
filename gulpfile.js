const gulp = require('gulp');
const cleanCSS = require('gulp-clean-css');
const del = require('del');
const htmlmin = require('gulp-htmlmin');
const inject = require('gulp-inject-string');

const dateStr = (new Date()).toGMTString();

gulp.task('minify-css', () => {
  return gulp.src('www/*.css')
    .pipe(cleanCSS({compatibility: 'ie8'}))
    .pipe(gulp.dest('dist'));
});

gulp.task('minify-html', () => {
  return gulp.src('www/index.html')
    .pipe(inject.replace('{{date}}', dateStr))
    .pipe(htmlmin({ collapseWhitespace: true }))
    .pipe(gulp.dest('dist'));
});

gulp.task('copy-assets', () => {
  return gulp.src('www/assets/*')
    .pipe(gulp.dest('dist/assets'));
});

gulp.task('clean', () => {
  return del(['dist']);
});

gulp.task('build', gulp.series(
  'minify-css',
  'minify-html',
  'copy-assets',
));
