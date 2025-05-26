# Use Alpine Linux as the base image
FROM alpine:3.18

# Install required packages
RUN apk add --no-cache \
    ffmpeg \
    rtsp-simple-server

# Create a test video
RUN ffmpeg -f lavfi -i testsrc=size=640x480:rate=30 -t 10 -c:v libx264 -pix_fmt yuv420p /test_stream.mp4

# Copy configuration and scripts
COPY rtsp-simple-server.yml /rtsp-simple-server.yml
COPY start.sh /start.sh

# Make start script executable
RUN chmod +x /start.sh

# Expose necessary ports
EXPOSE 8554 1935 8888

# Set the working directory
WORKDIR /


# Set the entrypoint
ENTRYPOINT ["/start.sh"]
