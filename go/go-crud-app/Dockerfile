# Use a more recent version of Go, such as 1.23 on Alpine
FROM golang:1.23-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the local directory to the container
COPY . .

# Download Go modules and dependencies
RUN go mod tidy

# Build the Go application (ensure you specify the correct path if needed)
RUN go build -o ./api   
# Expose the application port
EXPOSE 8000

# Set the command to run the Go binary
CMD [ "./api" ]

