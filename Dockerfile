FROM alpine:3.11 as builder
ARG VERSION=0.2.5
RUN apk add --no-cache wget tar
WORKDIR /tmp
RUN wget https://github.com/suyashkumar/ssl-proxy/releases/download/v${VERSION}/ssl-proxy-linux-amd64.tar.gz
RUN tar xf ssl-proxy-linux-amd64.tar.gz

FROM scratch

ARG VERSION=0.2.5
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/primeroz/ssl-proxy-docker" \
      org.label-schema.schema-version=$VERSION \
      org.label-schema.name="ssl-proxy" \
      org.label-schema.description="A build of https://github.com/suyashkumar/ssl-proxy" \
      org.label-schema.vendor="Primeroz" \
      maintainer="Francesco Ciocchetti <primeroznl@gmail.com>"

COPY --from=builder /tmp/ssl-proxy-linux-amd64 /ssl-proxy
RUN mkdir /tmp
WORKDIR /tmp
ENTRYPOINT ["/ssl-proxy"]
