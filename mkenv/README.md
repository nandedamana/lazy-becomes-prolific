# Generate env Files with Random Passwords

Don't be lazy and put some placeholder passwords in your Docker-related
configurations. Auto-generate them so that they become easier and
more secure at the same time. The script given here is an example for this.

## Usage

Invocation:

```
./mkenv.sh OUTFILE VARNAME1 [ OUTFILE2 VARNAME2 ... ]
```

Output example:

```
$ ./mkenv.sh pg-self.secret.env POSTGRES_PASSWORD app.secret.env DB_PASSWORD

$ cat pg-self.secret.env 
POSTGRES_PASSWORD=7coFMsro0y1sPvKGgEabPzTDnRsAEQBZ

$ cat app.secret.env 
DB_PASSWORD=7coFMsro0y1sPvKGgEabPzTDnRsAEQBZ
```
