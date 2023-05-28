# michaelkelly.org

The canonical location of this repo is:
<https://git.sr.ht/~mkelly/michaelkelly.org>. Other locations are mirrors.

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
in the `_site` directory.

Then, run `./scripts/deploy.sh` to do the actual deploy.
