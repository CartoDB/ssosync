FROM golang:alpine AS build

RUN apk add --no-cache git make

WORKDIR /build

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN make go-build

FROM alpine:3.9

COPY --from=build /build/ssosync /app/ssosync

ENTRYPOINT ["/app/ssosync"]