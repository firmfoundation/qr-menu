# Use the official Golang base image
FROM golang:1.20.6

# Set the working directory inside the container
WORKDIR /app

# Copy the built application into the container
COPY ./qrchaka .

# Copy the .env
COPY ./app.env .

# Copy working dir 
COPY ./templates /app/templates
COPY ./static /app/static

#copy working files
COPY ./jiret.ttf /app/jiret.ttf
COPY ./qr-template.png /app/qr-template.png

# Qr temp directory
RUN mkdir qr-outputs
RUN mkdir qr-scan-outputs

# Expose the port on which the application listens
EXPOSE 5055

# Set the command to run when the container starts
CMD ["./qrchaka"]