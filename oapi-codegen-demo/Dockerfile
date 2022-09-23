# This Dockerfile makes use of two optimization concepts:
#   1) Multistage Docker builds
#   2) `go mod download` before the code is copied, so that it'll be cached

FROM golang:1.17

COPY src/go.mod src/go.sum /app/
WORKDIR /app
RUN go mod download
COPY src /app
RUN go test ./...
RUN CGO_ENABLED=0 GOOS=linux go build

FROM alpine
COPY --from=0 /app/oapi-codegen-demo /app/oapi-codegen-demo
CMD [ "/app/oapi-codegen-demo" ]
