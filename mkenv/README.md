# Generate env Files with Random Passwords

Don't be lazy and put some placeholder passwords in your Docker-related
configurations. Auto-generate them so that they become easier and
more secure at the same time. The script given here is an example for this.

## Usage

Invocation:

```
./mkenv.sh OUTFILE1 VARNAME1 [ OUTFILE2 VARNAME2 ... ]
```

The script creates `OUTFILE1` with the content `VARNAME1=password`,
`OUTFILE2` with the content `VARNAME2=password`, etc. It generates only
one password per invocation, which is helpful if you have to share the same
password between, say, a database container and an app container under
different variable names.

Output example:

```
$ ./mkenv.sh pg-self.secret.env POSTGRES_PASSWORD app.secret.env DB_PASSWORD

$ cat pg-self.secret.env 
POSTGRES_PASSWORD=7coFMsro0y1sPvKGgEabPzTDnRsAEQBZ

$ cat app.secret.env 
DB_PASSWORD=7coFMsro0y1sPvKGgEabPzTDnRsAEQBZ
```
