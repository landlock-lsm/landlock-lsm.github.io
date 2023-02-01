#!/usr/bin/env bash

set -u -e -o pipefail

make html
rsync --archive --human-readable --human-readable --info=progress2 _build/html/ website/
