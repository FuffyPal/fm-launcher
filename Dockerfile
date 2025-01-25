FROM fedora-minimal As build

WORKDIR /workspace
RUN dnf install -y cargo && dnf clean all
COPY . /workspace/
RUN cargo build 

FROM  ubuntu:24.04
WORKDIR /app
COPY --from=build /workspace/target/debug/Baloncuk-launcher /app/
CMD ["/app/Baloncuk-launcher"]
