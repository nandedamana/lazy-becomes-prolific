oapi-codegen Demo
=================

This is a sample project that makes use of [oapi-codegen](https://github.com/deepmap/oapi-codegen)
to generate the boilerplate for an API server written in Go. The API is
described in a YAML file following the OpenAPI 3 specification.

After successful build and invocation, you'll get a server running at
`localhost:8080`, listening to serve requests to the endpoints
`/calc/sum?x=X&y=Y` and `/calc/diff?x=X&y=Y`.

Prerequisite
------------
* Go 1.19.1 (should work with a couple of previous versions)
* `go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@latest`  
  (make sure to add ~/go/bin/ to your $PATH)

Run the Server
--------------

Without Docker (run from inside *src/*):

```
go run .
```

Docker is an overkill for this project, but a Dockerfile has been included.
The file is interesting in the sense that it uses Docker's multi-stage build
system to reduce container size and Go's `go mod download` to save build time.
This file can also serve as a template for real projects.

To build and run the API server with Docker Compose, run this from inside the
project root:

```
docker-compose up -d --build
```

Testing
-------

To see the server in action, use `curl`:

```
$ curl 'localhost:8080/calc/sum?x=10&y=5'
15
```

A bash script is provided which checks the output for some random input
combinations. It also makes sure that error messages are returned for invalid
requests. Make sure to read the comments given in that script.


```
./test.sh
```

Experimentation
---------------

When making changes to *src/calc/api.yml*, make sure to regenerate the related
Go files using this command:

```
make -C make -C src/calc/
```

Why deepmap/oapi-codegen?
-------------------------

* It focuses on Go only
  - I thought this would result in less workarounds and a straightforward
    learning experience (true so far)

* The generated code can be kept intact and our code can be written in
  separate files under the classes we define (thanks to Go's interfaces).
  - Some other generators I've tried makes us edit the generated code,
    which will be rewritten once we modify the spec and regenerate.

Why chi?
--------

* Because chi looks clean, passing the http.ResponseWriter and http.Request
  objects directly to our handlers.
