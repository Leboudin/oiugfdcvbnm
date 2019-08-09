# Build the execution binary
FROM golang:1.12 as builder

WORKDIR /app

COPY . .

ARG GITHUB_TOKEN

ENV GITHUB_TOKEN $GITHUB_TOKEN

ENV GO111MODULE on

RUN git config --global url."https://$GITHUB_TOKEN:x-oauth-basic@github.com/".insteadOf "https://github.com/"

RUN go get -u github.com/Leboudin/common

RUN CGO_ENABLED=0 GOOS=linux go build -v -o application

# Package
FROM alpine

RUN apk add --no-cache ca-certificates curl

COPY --from=builder /app/application  /

CMD ["/application"]
