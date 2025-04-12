#!/usr/bin/env bash
set -euo pipefail

case ${1:-} in
	*)
		port=8080
		sh -c "wait-port $port; notify BE is ready \(port $port\) 👍" &
		pid=$!
		cleanup() {
			kill "$pid" &>/dev/null
		}
		trap cleanup EXIT
		scripts/run-server-api.sh
		;;
esac

