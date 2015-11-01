# Janjan

## Requirements

- Ruby
- bundler
- bower
- postgresql
- redis

## Setup

    bin/setup

  For debugging, it is recommended to add `a` to `d` subdomains for localhost.

    # /etc/hosts
    127.0.0.1       localhost a.localhost b.localhost c.localhost d.localhost

## Run

    bin/rails s -b 0.0.0.0
