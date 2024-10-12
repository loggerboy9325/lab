FROM golang:1.20-alpine AS build
RUN apk --no-cache add gcc g++ make ca-certificates
WORKDIR /go/src/go-grpc

# Copy Go module files and install dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application files and vendor folder
COPY vendor vendor
COPY order order 
COPY catalog catalog
COPY account account

# Build the application using the vendor folder for dependencies
RUN go build -mod=vendor -o /go/bin/app ./order/cmd/order

# Stage 2: Create a minimal final image
FROM alpine:3.18
WORKDIR /usr/bin

# Copy the compiled app binary from the build stage
COPY --from=build /go/bin/app .

# Expose the necessary port
EXPOSE 8080

# Set the entrypoint to the compiled binary
ENTRYPOINT [ "./app" ]

