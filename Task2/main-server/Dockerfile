FROM rust:latest
COPY . .
RUN cargo build --release
EXPOSE 8000
ENV ROCKET_ADDRESS=0.0.0.0
ENTRYPOINT ["./target/release/main-server"]
