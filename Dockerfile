# Build the execution binary
FROM golang:1.12 as builder

WORKDIR /app

COPY . .

ENV GO111MODULE on

RUN go get

RUN CGO_ENABLED=0 GOOS=linux go build -v -o application

# Package
FROM alpine

RUN apk add --no-cache ca-certificates curl

COPY --from=builder /app/application  /

CMD ["/application"]