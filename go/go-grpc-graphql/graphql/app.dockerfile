# Stage 1: Build the Go application
FROM golang:1.20-alpine AS build
RUN apk --no-cache add gcc g++ make ca-certificates
WORKDIR /go/src/go-grpc


# Copy Go modules files and install dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the vendor folder and all application code
COPY vendor vendor
COPY account account
COPY catalog catalog
COPY order order
COPY graphql graphql

# Build the application targeting the GraphQL service
RUN go build -mod=vendor -o /go/bin/app ./graphql

# Stage 2: Create a minimal final image
FROM alpine:3.18
WORKDIR /usr/bin

# Copy the compiled binary from the build stage
COPY --from=build /go/bin/app .

# Expose the necessary port
EXPOSE 8080

# Set the entrypoint to the compiled binary
ENTRYPOINT ["./app"]

