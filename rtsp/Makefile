.PHONY: build test clean prepare

# Prepare files for Docker build
prepare:
	@echo "📦 Preparing files for Docker build..."
	@cp docker/rtsp-simple-server.yml .
	@cp docker/start.sh .

# Build the RTSP server
dev-build: prepare
	@echo "🔨 Building RTSP server..."
	docker build -t rtsp-mock -f docker/Dockerfile .

# Run tests
test:
	@echo "🧪 Running tests..."
	ansible-playbook -i ../inventory.ini ansible/test.yml

# Clean up
clean:
	@echo "🧹 Cleaning up..."
	-docker rmi -f rtsp-mock 2>/dev/null || true
	rm -f rtsp-simple-server.yml start.sh test_stream.mp4

# Alias for backward compatibility
build: dev-build
