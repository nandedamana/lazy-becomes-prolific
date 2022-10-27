#!/bin/bash

set -e
set -o nounset

usage() {
	>&2 echo "$0" OUTFILE1 VARNAME1 [ OUTFILE2 VARNAME2 ... ]
}

outfiles=()
varnames=()

while [ 1 ]; do
	if [ -z "${1-}" ] || [ -z "${2-}" ]; then
		usage
		exit 1
	fi

	outfiles+=("$1")
	varnames+=("$2")
	shift
	shift

	if [ -z "${1-}" ]; then # no more f-v pair
		break
	fi
done

passwd="$(head -c 24 /dev/urandom|base64 --wrap=0)"

for i in "${!outfiles[@]}"; do
	outf=${outfiles[$i]}
	vnam=${varnames[$i]}

	if [ -e "$outf" ]; then
		>&2 echo "$outf already exists."
	else
		echo "$vnam=$passwd" > "$outf"
	fi
done
