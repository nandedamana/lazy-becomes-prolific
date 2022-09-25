# Stringification of C Enum

Often do we find ourselves in a situation where we need to print the name of an
enum member for debugging or logging purpose. But enum members are just integer
constants and their names don't get past the compilation phase (well, maybe for
the use of debuggers like `gdb` if you compile in debug mode, but certainly not
for the use of your program itself). Written in C code, this is the situation:

```
typedef enum SomeEnum {
	MEMBER_1,
	MEMBER_2,
	...
} SomeEnum;

int some_fun(SomeEnum opt, int x, int y, ...)
{
	fprintf(stderr,
		"some_fun() called with opt = %s\n", id_of_opt);
```

The challenge is to obtain `id_of_opt`. There are multiple solutions including
setting up an array of member names, writing a function that employs `switch`,
etc.

*main.c* under *manual/* show how this is done without any automation. Although
simple to set up, we are then left to keep the enum and the stringification
array (or function) in sync manually. But it is easy to miss, and can cause
anything from incorrect logs to segfaults.

*Makefile* under *sed/* automates this with `sed`. It generates the array if
missing, and regenerates when the source (*main.c*) is changed. It is
recommended to keep the enum in a separate header file for real projects to
avoid unnecessary regenerations.

NOTE: Not to be confused with the C preprocessor feature called
*Stringification*. It cannot solve the general problem described here.
