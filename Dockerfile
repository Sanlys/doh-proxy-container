FROM rust:latest AS builder

RUN cargo install doh-proxy

FROM debian:stable-slim

COPY --from=builder /usr/local/cargo/bin/doh-proxy /usr/local/bin/doh-proxy

EXPOSE 80

ENV LISTEN_ADDRESS="0.0.0.0:80"
ENV UPSTREAM_DNS="127.0.0.1:53"
ENV HOSTNAME="example.com"

CMD ["sh", "-c", "doh-proxy -H \"$HOSTNAME\" -l \"$LISTEN_ADDRESS\" -u \"$UPSTREAM_DNS\""]
