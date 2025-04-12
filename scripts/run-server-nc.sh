#!/usr/bin/env bash
set -euo pipefail

for s in $(seq 10 1); do
	echo "$s"
	sleep 0.25
done

serve() {
	nc -l 8080 <<-EOF
	HTTP/1.1 200 OK
	EOF
}

while serve ; do :; done

