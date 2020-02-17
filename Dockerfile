# Create a minimal container to run a Golang static binary
FROM golang:1.12 as builder
ENV CGO_ENABLED 0
ENV GOCACHE /go/.cache/go-build
WORKDIR /go/src/whoami
ADD . .
RUN go get -v ./...
RUN go build -a --installsuffix cgo --ldflags="-s" -o whoami

FROM scratch
COPY --from=builder /go/src/whoami/whoami /whoami
ENTRYPOINT ["/whoami"]
CMD ["-port", "-5000"]
EXPOSE 5000
