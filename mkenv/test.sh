#!/usr/bin/env bash
# Nandakumar Edamana
# 2022-10

set -o nounset

scriptdir="$(dirname "$0")"
mkenv="$scriptdir/mkenv.sh"

failcount=0

fail() {
	echo ...FAIL
	failcount="$(echo "$failcount" + 1|bc)"
}

echo TEST: No args
"$mkenv" 2>/dev/null
if [ $? -eq 1 ]; then echo ...PASS; else fail; fi

echo TEST: One arg
rm -rf /tmp/n96e-mkenv-test.env
"$mkenv" /tmp/n96e-mkenv-test.env 2>/dev/null
if [ $? -eq 1 ] && [ ! -e /tmp/n96e-mkenv-test.env ]; then
	echo ...PASS
else
	fail
fi

echo TEST: Three args
rm -rf /tmp/n96e-mkenv-test2.env
"$mkenv" /tmp/n96e-mkenv-test.env VNAME1 /tmp/n96e-mkenv-test2.env 2>/dev/null
if [ $? -eq 1 ] && [ ! -e /tmp/n96e-mkenv-test2.env ]; then
	echo ...PASS
else
	fail
fi

echo TEST: Two args
rm -rf /tmp/n96e-mkenv-test.env
"$mkenv" /tmp/n96e-mkenv-test.env VNAME1 2>/dev/null
if [ $? -eq 0 ] && [ "$(grep -E '^VNAME1=.+' /tmp/n96e-mkenv-test.env)" ]; then
	echo ...PASS
else
	fail
fi
rm -rf /tmp/n96e-mkenv-test.env

echo TEST: Four args
rm -rf /tmp/n96e-mkenv-test.env /tmp/n96e-mkenv-test2.env
"$mkenv" /tmp/n96e-mkenv-test.env VNAME1 /tmp/n96e-mkenv-test2.env VNAME2 2>/dev/null
if [ $? -eq 0 ] && [ "$(grep -E '^VNAME1=.+' /tmp/n96e-mkenv-test.env)" ] && [ "$(grep -E '^VNAME2=.+' /tmp/n96e-mkenv-test2.env)" ]; then
	echo ...PASS
else
	fail
fi
rm -rf /tmp/n96e-mkenv-test.env /tmp/n96e-mkenv-test2.env

echo TEST: Four args: content equality
rm -rf /tmp/n96e-mkenv-test.env /tmp/n96e-mkenv-test2.env
"$mkenv" /tmp/n96e-mkenv-test.env VNAME1 /tmp/n96e-mkenv-test2.env VNAME1 2>/dev/null
if [ $? -eq 0 ] && [ "$(grep -E '^VNAME1=.+' /tmp/n96e-mkenv-test.env)" ] && [ "$(grep -E '^VNAME1=.+' /tmp/n96e-mkenv-test2.env)" ] && [ ! "$(diff /tmp/n96e-mkenv-test.env /tmp/n96e-mkenv-test2.env)" ]; then
	echo ...PASS
else
	fail
fi
rm -rf /tmp/n96e-mkenv-test.env /tmp/n96e-mkenv-test2.env

echo "Total fail count: $failcount"
if [ "$failcount" -gt 0 ]; then
	exit 1
fi
