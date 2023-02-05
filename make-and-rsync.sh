#!/usr/bin/env bash

set -u -e -o pipefail

make html
rm -r website/_static/
rsync --archive --human-readable --human-readable --info=progress2 _build/html/ website/
