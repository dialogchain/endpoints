#!/bin/sh
set -e

# Start RTSP server in the background
echo "Starting RTSP server..."
rtsp-simple-server /rtsp-simple-server.yml &
RTSP_PID=$!

# Wait for RTSP server to start
sleep 2

# Start streaming the test video in a loop
echo "Starting RTSP test stream on rtsp://localhost:8554/stream"
ffmpeg -hide_banner -loglevel error -re -stream_loop -1 -i /test_stream.mp4 -c:v copy -f rtsp -rtsp_transport tcp rtsp://localhost:8554/stream &
FFMPEG_PID=$!

# Function to handle shutdown
shutdown() {
    echo "Shutting down..."
    kill $FFMPEG_PID 2>/dev/null
    kill $RTSP_PID 2>/dev/null
    wait $FFMPEG_PID 2>/dev/null
    wait $RTSP_PID 2>/dev/null
    exit 0
}

# Set up trap to catch signals
trap shutdown TERM INT

# Keep container running
echo "RTSP server is running. Press Ctrl+C to stop."
wait $RTSP_PID
