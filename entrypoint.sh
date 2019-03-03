#!/bin/sh

envsubst < /boto.template > ~/.boto

exec "$@"
