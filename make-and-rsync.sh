#!/usr/bin/env bash

set -u -e -o pipefail

uv sync

uv run make clean dirhtml

rsync \
	--archive \
	--delete \
	--human-readable --human-readable \
	--info=progress2 \
	_build/dirhtml/* talks \
	website/

echo
echo "To launch the website:"
echo "uv run python -m http.server -b 127.0.0.1 -d website"
