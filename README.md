# michaelkelly.org

Contents of www.michaelkelly.org.

The site is built with [Jekyll](https://jekyllrb.com).

## Setup

1. Get ruby/gems: <https://jekyllrb.com/docs/installation/>
2. Install node (or any other backend for ExecJS:
   https://github.com/rails/execjs). `apt install nodejs`, etc.
3. Install dependencies of this project: `bundle install`

Now you'll be able to use the scripts in the `scripts` directory.

## Local testing

For development, you can run `./scripts/preview.sh`. It'll bind on port 8080
(beware, it's accessible from other hosts!)

## Deployment

As a last check, you can run `./scripts/generate.sh`, then inspect the output
in the `_site` directory.

Then, run `./scripts/deploy.sh` to do the actual deploy.
