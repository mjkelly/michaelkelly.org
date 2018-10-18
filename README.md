# michaelkelly.org

Contents of www.michaelkelly.org.

## Deploying

This repo is hooked up to Netlify, so updating just requires committing to
`master`.

Everything is in `www`, but we have build scripts to build `dist` (which
contains minified output).

### Local testing

You can view the files in `www` directly.

To test the build process, you'll have to run `gulp`. That entails:

1. Install `npm`, which is part of `nodejs`: https://nodejs.org/en/
2. Install packages: `npm install`
3. Build everything with gulp: `./node_modules/.bin/gulp build`
4. Output files will be in `dist`.
