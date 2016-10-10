#!/bin/bash
set -e

chown -R $APP_USER $APP_DIR

exec gosu $APP_USER $@
