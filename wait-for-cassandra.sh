#!/bin/bash
# wait-for-cassandra.sh

set -e

host="$1"
port="$2"
shift 2
cmd="$@"

until cqlsh $host $port -e "DESCRIBE keyspaces"; do
  >&2 echo "Cassandra is unavailable - sleeping"
  sleep 1
done

>&2 echo "Cassandra is up - executing command"
exec $cmd
