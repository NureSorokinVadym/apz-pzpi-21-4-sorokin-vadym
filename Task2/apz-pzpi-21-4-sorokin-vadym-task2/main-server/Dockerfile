FROM rust:latest

WORKDIR main-server

COPY Rocket.toml Rocket.toml
COPY Cargo.toml Cargo.toml
COPY Cargo.lock Cargo.lock
COPY mock-src src

RUN cargo build --release

RUN rm -r target/release/deps/main_server*
RUN rm -r src

COPY src src

RUN cargo build --release

EXPOSE 8000
ENV ROCKET_ADDRESS=0.0.0.0
ENTRYPOINT ["./target/release/main-server"]
