.PHONY: help build test clean all test-grpc test-rtsp test-http test-mqtt test-webrtc logs lint test-coverage check-deps

# Check if requirements are installed
check-deps:
	@echo "🔍 Checking for required tools..."
	@command -v docker >/dev/null 2>&1 || (echo "❌ Error: Docker is not installed" && exit 1)
	@command -v docker-compose >/dev/null 2>&1 || (echo "❌ Error: Docker Compose is not installed" && exit 1)
	@command -v python3 >/dev/null 2>&1 || (echo "❌ Error: Python 3 is not installed" && exit 1)
	@echo "✅ All required tools are installed"

# Install development dependencies
install-dev:
	@echo "📦 Installing development dependencies..."
	pip install -r requirements-dev.txt

# Default target
help:
	@echo "\n📦 Available targets:\n"
	@echo "  build          - Build all endpoint containers"
	@echo "  up             - Start all endpoints"
	@echo "  down           - Stop all endpoints"
	@echo "  logs           - Show logs for all services"
	@echo "  test           - Run all endpoint tests"
	@echo "  test-rtsp      - Run RTSP server tests"
	@echo "  test-http      - Run HTTP server tests"
	@echo "  test-grpc      - Run gRPC server tests"
	@echo "  test-mqtt      - Run MQTT broker tests"
	@echo "  test-webrtc    - Run WebRTC server tests"
	@echo "  lint           - Run linter on all services"
	@echo "  test-coverage  - Run tests with coverage report"
	@echo "  clean          - Clean up all endpoints and volumes"
	@echo "\nFor more information see README.md\n"

# Build all endpoint containers
build: check-deps
	@echo "🚀 Building all services..."
	@for dir in rtsp http webrtc grpc mqtt; do \
		echo "\n🔨 Building $$dir..."; \
		if ! $(MAKE) -C $$dir build; then \
			echo "❌ Failed to build $$dir"; \
			exit 1; \
		fi; \
	done
	@echo "\n✅ All services built successfully!"

# Start all endpoints
up:
	docker-compose -f docker-compose.yml up -d

# Stop all endpoints
down:
	docker-compose -f docker-compose.yml down

# Test targets
test: check-deps
	@echo "🚀 Running all tests..."
	ansible-playbook -i inventory.ini test.yml

test-rtsp:
	@echo "🎬 Testing RTSP server..."
	ansible-playbook -i inventory.ini test.yml --tags rtsp

test-http:
	@echo "🌐 Testing HTTP server..."
	ansible-playbook -i inventory.ini test.yml --tags http

test-grpc:
	@echo "🔌 Testing gRPC server..."
	$(MAKE) -C grpc test

test-mqtt:
	@echo "📡 Testing MQTT broker..."
	ansible-playbook -i inventory.ini test.yml --tags mqtt

test-webrtc:
	@echo "📹 Testing WebRTC server..."
	ansible-playbook -i inventory.ini test.yml --tags webrtc

# Code quality
lint: check-deps
	@echo "🧹 Running linters..."
	@if ! command -v pylint >/dev/null 2>&1; then \
		echo "❌ pylint is not installed. Run 'make install-dev' first."; \
		exit 1; \
	fi
	find . -name "*.py" -exec pylint {} \;

# Test coverage
test-coverage: check-deps
	@echo "📊 Running tests with coverage..."
	@if ! command -v pytest >/dev/null 2>&1 || ! command -v coverage >/dev/null 2>&1; then \
		echo "❌ Test dependencies not found. Run 'make install-dev' first."; \
		exit 1; \
	fi
	coverage run -m pytest tests/ || (echo "❌ Tests failed"; exit 1)
	coverage report -m

# Logs
logs: check-deps
	@echo "📝 Showing logs for all services..."
	@if [ ! -f docker-compose.yml ]; then \
		echo "❌ docker-compose.yml not found. Are you in the right directory?"; \
		exit 1; \
	fi
	docker-compose logs -f

# Clean up all endpoints
clean:
	@echo "🧹 Cleaning up..."
	@for dir in rtsp http webrtc grpc mqtt; do \
		if [ -f "$$dir/Makefile" ]; then \
			$(MAKE) -C $$dir clean || true; \
		fi \
	done
	@if [ -f docker-compose.yml ]; then \
		docker-compose -f docker-compose.yml down -v --remove-orphans; \
	fi
	@echo "✅ Cleanup complete!"

# Show service status
status: check-deps
	@echo "🔄 Checking services status..."
	@docker-compose ps || (echo "❌ Failed to check services"; exit 1)
