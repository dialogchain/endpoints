# Mock Network Services

A comprehensive collection of mock network service implementations for testing and development purposes. This project provides containerized mock services for various network protocols, making it easy to test client applications without requiring actual backend services.

## Features

- **RTSP Server**: Simulates an RTSP video streaming server with test streams
- **HTTP Server**: Lightweight REST API server with common endpoints
- **gRPC Server**: Complete gRPC service with support for different RPC patterns
- **WebRTC Server**: WebRTC signaling server implementation
- **MQTT Broker**: MQTT message broker with WebSocket support

## Quick Start

1. **Prerequisites**:
   - Docker and Docker Compose
   - Make
   - Python 3.7+

2. Clone and start all services:
   ```bash
   # Clone the repository
   git clone https://github.com/dialogchain/endpoints.git
   cd endpoints
   
   # Build and start all services
   make build
   make up
   ```

3. Verify services are running:
   ```bash
   docker ps
   ```

4. Run tests:
   ```bash
   # Run all tests
   make test
   
   # Or run specific service tests
   make test-rtsp
   make test-http
   make test-grpc
   ```

5. Stop services:
   ```bash
   make down
   ```

## Service Details

### RTSP Server

- **Ports**: 
  - 8554 (RTSP)
  - 8888 (HTTP)
- **Test Streams**:
  - `rtsp://localhost:8554/stream`
  - `rtsp://localhost:8554/test`
- **Features**:
  - Simulates video streaming
  - HTTP interface for stream management
  - Multiple concurrent streams support

### HTTP Server

- **Port**: 8080
- **Base URL**: `http://localhost:8080`
- **Endpoints**:
  - `GET /` - Service status
  - `GET /api/data` - Retrieve sample data
  - `POST /api/echo` - Echo back request data
  - `GET /api/status/{code}` - Returns specified HTTP status code
  - `GET /api/delay/{seconds}` - Simulates delayed response
- **Features**:
  - JSON request/response support
  - CORS enabled
  - Request logging

### gRPC Server

- **Ports**:
  - 50051 (gRPC)
  - 8000 (Prometheus metrics)
- **Service**: `example.Greeter`
- **Methods**:
  - `SayHello` - Simple unary RPC
  - `StreamData` - Server streaming RPC
  - `ClientStream` - Client streaming RPC
  - `BidirectionalStream` - Bidirectional streaming RPC
- **Features**:
  - Health check endpoint
  - Prometheus metrics
  - Reflection enabled
  - Graceful shutdown

### MQTT Broker

- **Ports**:
  - 1883 (MQTT)
  - 9001 (MQTT over WebSocket)
- **Features**:
  - MQTT 3.1.1 and 5.0 support
  - WebSocket interface
  - Authentication support
  - Topic wildcards

### WebRTC Server

- **Port**: 8443
- **Features**:
  - WebSocket signaling
  - ICE/STUN/TURN support
  - Multi-client connections
  - Secure WebSocket (WSS) support

## Testing

### Using Makefile

```bash
# Run all tests
make test

# Test specific services
make test-rtsp
make test-http
make test-grpc
make test-mqtt
make test-webrtc
```

### Using Ansible

Run all tests:
```bash
ansible-playbook -i inventory.ini test.yml
```

Run specific service tests:
```bash
ansible-playbook -i inventory.ini test.yml --tags rtsp
ansible-playbook -i inventory.ini test.yml --tags http
ansible-playbook -i inventory.ini test.yml --tags grpc
ansible-playbook -i inventory.ini test.yml --tags mqtt
ansible-playbook -i inventory.ini test.yml --tags webrtc
```

## Development

### Project Structure

```
endpoints/
├── grpc/           # gRPC server implementation
│   ├── docker/      # Docker configuration
│   ├── ansible/     # Ansible test cases
│   └── proto/       # Protocol buffer definitions
├── http/            # HTTP server
│   ├── docker/
│   └── ansible/
├── mqtt/           # MQTT broker
│   ├── docker/
│   └── ansible/
├── rtsp/           # RTSP server
│   ├── docker/
│   └── ansible/
└── webrtc/         # WebRTC server
    ├── docker/
    └── ansible/
```

### Adding a New Service

1. Create a new directory under `endpoints/`
2. Add the following structure:
   ```
   new-service/
   ├── docker/
   │   └── Dockerfile
   ├── ansible/
   │   └── test.yml
   └── Makefile
   ```
3. Update root files:
   - Add service to `docker-compose.yml`
   - Update root `Makefile` with build/test commands
   - Add test task to `test.yml`

## Monitoring

- **Prometheus Metrics**: Available at `http://localhost:8000/metrics` for gRPC service
- **Docker Logs**: View logs for individual services using `docker logs <container-name>`

## Clean Up

Stop and remove all containers, networks, and volumes:

```bash
make down
make clean  # Removes built images
```

## License

This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.
make clean
```
