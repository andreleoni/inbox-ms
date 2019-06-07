#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# echo "Waiting for Redis to start..."
# while ! nc -z redis 6379; do sleep 0.1; done
# echo "Redis is up - execuring command"

rails s -b 0.0.0.0 -p 3001
