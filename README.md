# Janjan

## Requirements

- Ruby
- bundler
- bower
- postgresql
- redis
- phantomjs >= 2 for testing

## Setup

    bin/setup

  For debugging, it is recommended to add `a` to `d` subdomains for localhost.

    # /etc/hosts
    127.0.0.1       localhost a.localhost b.localhost c.localhost d.localhost

## Run

  1. Run application server

    bin/rails s -b 0.0.0.0

  2. Visit http://localhost:3000/debug
