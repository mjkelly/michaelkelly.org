# michaelkelly.org

The canonical location of this repo is:
<https://github.com/mjkelly/michaelkelly.org>. Other locations are mirrors.

Contents of www.michaelkelly.org. 

The site is built with [Hugo](https://gohugo.io/).

## Setup

1. Install Hugo: https://gohugo.io/getting-started/quick-start/

Now you'll be able to use the scripts in the `scripts` directory.

## Local testing

For development, you can run `./scripts/preview.sh`. It'll bind on port 8080
(beware, it's accessible from other hosts!)

## Deployment

As a last check, you can run `./scripts/generate.sh`, then inspect the output
in the `public` directory.

Then, run `./scripts/deploy.sh` to do the actual deploy. If you use a
non-default aws profile (like I do), run
`AWS_PROFILE=admin ./scripts/deploy.sh` or similar.
