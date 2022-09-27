# C Preprocessor Abuse

Usage:

```
$ cpp hello.c |egrep -v '^#|^$'
Hello, Geeks!
Hello, Nerds!
```

```
$ cpp -DMORNING hello.c |egrep -v '^#|^$'
Good morning, Geeks!
Good morning, Nerds!
```
