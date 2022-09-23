#!/bin/bash

# Just some random tests; not systematic at all.
# In a real project, make sure to check HTTP status code, content type,
# all combinations and extremes, etc.

set -e

echo 'Checking if curl is available...'
which curl > /dev/null && echo '    OK.'

# All these error messages are auto-generated in the server
echo 'error on invalid path' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc')" = 'no matching operation was found' && echo PASS || (echo FAIL && exit 1)
echo 'error on missing query param x for sum' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/sum?y=12')" = 'parameter "x" in query has an error: value is required but missing' && echo PASS || (echo FAIL && exit 1)
echo 'error on missing query param y for sum' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/sum?x=10')" = 'parameter "y" in query has an error: value is required but missing' && echo PASS || (echo FAIL && exit 1)
echo 'error on missing query param x for diff' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/diff?y=12')" = 'parameter "x" in query has an error: value is required but missing' && echo PASS || (echo FAIL && exit 1)
echo 'error on missing query param y for diff' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/diff?x=10')" = 'parameter "y" in query has an error: value is required but missing' && echo PASS || (echo FAIL && exit 1)

echo 'error on illegal y value for diff' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/diff?x=10&y=someString')" = 'parameter "y" in query has an error: value someString: an invalid integer: invalid syntax' && echo PASS || (echo FAIL && exit 1)

echo '10 + 12 = 22' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/sum?x=10&y=12')" -eq 22 && echo PASS || (echo FAIL && exit 1)
echo '10 + -3 = 7' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/sum?x=10&y=-3')" -eq 7 && echo PASS || (echo FAIL && exit 1)
echo '-10 + 12 = 2' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/sum?x=-10&y=12')" -eq 2 && echo PASS || (echo FAIL && exit 1)
echo '10 - 12 = -2' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/diff?x=10&y=12')" -eq -2 && echo PASS || (echo FAIL && exit 1)
echo '-8 - 7 = -15' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/diff?x=-8&y=7')" -eq -15 && echo PASS || (echo FAIL && exit 1)
echo '-8 - -7 = -1' && echo -n '    ' && test "$(curl --no-progress-meter 'localhost:8080/calc/diff?x=-8&y=-7')" -eq -1 && echo PASS || (echo FAIL && exit 1)
