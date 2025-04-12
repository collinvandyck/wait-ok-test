test:
    @scripts/run-test.sh

api:
    (cd api && ./gradlew bootRun --info --console=plain)
