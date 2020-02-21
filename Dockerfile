FROM alpine:3.11 as builder
ARG VERSION=0.2.5
RUN apk add --no-cache wget tar
WORKDIR /tmp
RUN wget https://github.com/suyashkumar/ssl-proxy/releases/download/v${VERSION}/ssl-proxy-linux-amd64.tar.gz
RUN tar xf ssl-proxy-linux-amd64.tar.gz

FROM scratch
COPY --from=builder /tmp/ssl-proxy-linux-amd64 /ssl-proxy
ENTRYPOINT ["/ssl-proxy"]
