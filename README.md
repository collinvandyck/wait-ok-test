# Overview

This is a test project to see why I am seeing weird problems with background jobs that wait for a
port to become available and then notify.

This does not work for some reason:

```sh
case ${1:-} in
    wt)
        shift
        run-tests web:test "$@"
        ;;
    wit)
        shift
        run-tests web:integrationTest "$@"
        ;;
    qeit)
        shift
        run-tests query-engine:integrationTest "$@"
        ;;
    wr)
        sh -c 'while ! curl --fail-with-body localhost:8080; do sleep 0.5; done; notify BE is ready 👍' &
        pid=$!
        cleanup() {
            kill "$pid" 2>/dev/null || true
        }
        trap cleanup EXIT
        gradle web:bootRun --info --console=plain | tspin
        ;;
    *)
        gradle "$@"
        ;;
esac
```

But `run-test.sh` DOES work.

So it's either an issue with running gradle in this way or perhaps the proxy on my work computer is interfering.

Next step: create a gradle project inside of this repo and have run-test.sh have it spin up a REST server for the script to connect to.
