#!/usr/bin/env bash
set -euo pipefail

case ${1:-} in
	*)
		sh -c 'while ! nc -z localhost 1234; do sleep 0.5; done; notify BE is ready 👍' &
		pid=$!
		cleanup() {
			kill "$pid" &>/dev/null
		}
		trap cleanup EXIT
		scripts/run-server.sh
		;;
esac

