# michaelkelly.org

Contents of www.michaelkelly.org.

## Local testing

You can view the files in `www` directly.

To test the build process, you'll have to run `gulp`. That entails:

1. Install `npm`, which is part of `nodejs`: https://nodejs.org/en/
2. Run `make`.

Yes, we chain make -> gulp, and that's a little silly. I'm doing that so that I
can swap out the guts of the minification process when I find something that
doesn't rely on 20MB of node!

## Deploying

This repo is hooked up to Netlify, so updating just requires committing to
`master`.

Everything is in `www`, but we have build scripts to build `dist` (which
contains minified output).

