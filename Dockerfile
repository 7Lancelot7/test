FROM golang:1.18-alpine as buildbase

RUN apk add git build-base

WORKDIR /go/src/y
COPY vendor .
COPY . .

RUN GOOS=linux go build  -o /usr/local/bin/blob /go/src/y


FROM alpine:3.9

COPY --from=buildbase /usr/local/bin/blob /usr/local/bin/blob
RUN apk add --no-cache ca-certificates

ENTRYPOINT ["blob"]
