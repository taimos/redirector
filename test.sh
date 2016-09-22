#!/usr/local/bin/bash

PORT=${1?:Missing port info}

echo "Testing server on port $PORT"

callServer() {
    HOST=$1
    PATHPART=$2
    EXPECTED=$3

    RES=$(curl -sSI -H "Host: ${HOST}" http://localhost:${PORT}${PATHPART})

    LOC=$(echo "$RES" | grep "Location" | tr -d "\r\n")

    if [[ ${LOC} == "Location: ${EXPECTED}" ]]; then
        echo "Success: Host ${HOST} and path ${PATHPART} -> ${LOC}"
    else
        echo "Error: Host ${HOST} and path ${PATHPART} expected ${EXPECTED} but got ${LOC}"
        exit 1
    fi
}

callServer www.test.de "/foo" "https://www.test.de/foo"
callServer www.test.de "/foo?foobar" "https://www.test.de/foo?foobar"
callServer www.test.de "" "https://www.test.de/"