#!/bin/bash -eu

set -o pipefail


# Run a scheme file with all the mechanics stuff loaded.

# The first run will be slow due to compilation, after that it will be fast.


# Install mit-scheme with sudo apt install mit-scheme


# Portably get the directory that this script is in
SCRIPTDIR="$( cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd )"


usage() {
    cat <<EOF >&2
Usage: run.sh [ARGS]

    --file, -f: run a file instead of an interactive console

    --help, -h:    Show this help
EOF
}

file=""
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 1
            ;;
        -f|--file)
            shift
            file="$(readlink -f "$1")"
            ;;
        *)
            echo "Unrecognised argument $1" >&2
            usage
            exit 1
            ;;
    esac
    shift
done


cd "$SCRIPTDIR/scmutils/src"
export MITSCHEME_HEAP_SIZE=100000


if [ -z "$file" ]; then
    rlwrap mit-scheme --quiet --eval '(load "compile")' --eval '(load "load")' "$@"
else
    mit-scheme --quiet --eval '(load "compile")' --eval '(load "load")' "$@" < "$file"
fi
