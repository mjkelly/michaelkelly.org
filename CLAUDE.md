# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal website for michaelkelly.org, built with Hugo static site generator. Hosted on AWS S3 with CloudFront CDN.

## Commands

**Local development:**
```bash
./scripts/preview.sh  # Starts Hugo dev server on port 8080 (binds to all interfaces)
```

**Build for production:**
```bash
./scripts/generate.sh  # Builds to ./public with minification and git revision stamp
```

**Deploy:**
```bash
./scripts/deploy.sh  # Builds, syncs to S3, invalidates CloudFront cache
```

Deployment requires AWS CLI configured with an `admin` profile in `~/.aws/config`.

## Architecture

- `content/` - Site pages as Markdown or HTML (frontmatter defines menus)
- `layouts/` - Hugo templates (`_default/baseof.html` is the base, `partials/nav.html` for navigation)
- `assets/css/main.css` - Site styles (processed and fingerprinted by Hugo)
- `static/` - Static files copied directly to output (resume PDFs, GPG key, logos)
- `scripts/` - Build and deployment bash scripts
- `.builds/` - SourceHut CI configuration (deploy.yml for production, mirror.yml for GitHub sync)

Hugo configuration in `config.toml` disables taxonomies and enables git info for modification tracking.

## Repository Locations

- Primary: https://git.sr.ht/~mkelly/michaelkelly.org
- Mirror: https://github.com/mjkelly/michaelkelly.org
