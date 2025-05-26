# Use the official RTSP server image
FROM aler9/rtsp-simple-server:latest

# Install FFmpeg in a separate stage
FROM alpine:3.18 as ffmpeg
RUN apk add --no-cache ffmpeg
RUN ffmpeg -f lavfi -i testsrc=size=640x480:rate=30 -t 10 -c:v libx264 -pix_fmt yuv420p /test_stream.mp4

# Final stage
FROM aler9/rtsp-simple-server:latest

# Copy FFmpeg and test stream from the ffmpeg stage
COPY --from=ffmpeg /usr/bin/ffmpeg /usr/local/bin/
COPY --from=ffmpeg /test_stream.mp4 /

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
