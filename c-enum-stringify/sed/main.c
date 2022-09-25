#include <assert.h>
#include <stdio.h>

#include "opstr.gen.h"

typedef enum Operation {
	OP_SUM,
	OP_DIFF,
	OP_LARGEST,
	OP_SMALLEST,
} Operation;

int calc(int x, int y, Operation op)
{
	#ifdef DEBUG
	fprintf(stderr,
		"calc() called with x = %d, y = %d and op = %s\n",
		x, y, opstr[op]);
	#endif

	switch(op) {
	case OP_SUM:
		return x + y;
		break;
	case OP_DIFF:
		return x - y;
		break;
	case OP_LARGEST:
		return (x > y)? x: y;
		break;
	case OP_SMALLEST:
		return (x < y)? x: y;
		break;
	default:
		assert(0);
	}
}

int main() {
	printf("7 + 13 = %d\n", calc(7, 13, OP_SUM));
	printf("7 - 13 = %d\n", calc(7, 13, OP_DIFF));
	printf("Largest of 7 and 13 = %d\n", calc(7, 13, OP_LARGEST));
	printf("Smallest of 7 and 13 = %d\n", calc(7, 13, OP_SMALLEST));

	return 0;
}
