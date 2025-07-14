#!/usr/bin/env bash

set -u -e -o pipefail

make html

rsync \
	--archive \
	--delete \
	--human-readable --human-readable \
	--info=progress2 \
	_build/html/* talks \
	website/

if [[ -n "$(git status --short --porcelain)" ]]; then
	echo "ERROR: Dirty worktree" >&2
	exit 1
fi
COMMIT="$(git log --no-walk --format=%H)"

pushd website
git add -A
git commit --edit -m "index: XXX" -m "Built from commit ${COMMIT}"
popd
