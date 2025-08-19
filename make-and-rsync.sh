#!/usr/bin/env bash

set -u -e -o pipefail

VENV=".venv"

if [[ ! -e "${VENV}" ]]; then
	python -m venv "${VENV}"
	INSTALLED=false
else
	INSTALLED=true
fi

source "${VENV}/bin/activate"

if ! ${INSTALLED}; then
	pip install --requirement requirements.txt \
		myst_parser \
		sphinx \
		sphinx-book-theme \
		sphinx_design
fi

make clean dirhtml

rsync \
	--archive \
	--delete \
	--human-readable --human-readable \
	--info=progress2 \
	_build/dirhtml/* talks \
	website/

echo
echo "To launch the website:"
echo "python -m http.server -b 127.0.0.1 -d website"
