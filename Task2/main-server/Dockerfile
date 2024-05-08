FROM rust:latest
COPY . .
RUN cargo build --release
ENTRYPOINT ["./target/release/main-server"]
