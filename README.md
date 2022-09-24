# Code Generation Examples for the Lazy

A repo to host working examples for the use of code generation tools and
techniques. Started as part of my
[Open Source India 2022](https://www.opensourceindia.in/)
talk on the topic *Code Generation: How the Lazy Becomes the Prolific* (see the
[speaker page](https://www.opensourceindia.in/osi-speakers-2022/nandakumar-edamana/)).

Example given here are meant to serve as demos, learning materials and
templates for real project at the same time. They include adequate
documentation, build scripts and even some basic test scripts, just to encourage
test automation. Please refer to the individual README files for more info.

## Tools and Techniques Used

* OpenAPI 3 (tool: [oapi-codegen](https://github.com/deepmap/oapi-codegen))
* Docker
  - multi-stage builds to reduce container size
  - `go mod download` to reduce build time
* `make`
* Very basic test automation with `bash`
