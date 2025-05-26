FROM aler9/rtsp-simple-server:latest AS builder

# Install FFmpeg for test stream generation
RUN apk add --no-cache ffmpeg

# Create a test video
RUN ffmpeg -f lavfi -i testsrc=size=640x480:rate=30 -t 10 -c:v libx264 -pix_fmt yuv420p /test_stream.mp4

# Final stage
FROM aler9/rtsp-simple-server:latest

# Install FFmpeg
RUN apk add --no-cache ffmpeg

# Copy the test video from builder
COPY --from=builder /test_stream.mp4 /test_stream.mp4

# Copy configuration and scripts
COPY rtsp-simple-server.yml /rtsp-simple-server.yml
COPY start.sh /start.sh

# Make start script executable
RUN chmod +x /start.sh

# Expose necessary ports
EXPOSE 8554 1935 8888

# Set the entrypoint
ENTRYPOINT ["/start.sh"]
