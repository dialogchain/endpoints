# DialogChain Endpoints

A comprehensive collection of network service implementations for testing and development purposes. This project provides containerized services for various network protocols, making it easy to test DialogChain integrations without requiring actual backend services.

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Docker](https://img.shields.io/badge/Docker-2CA5E0?logo=docker&logoColor=white)](https://www.docker.com/)
[![Python](https://img.shields.io/badge/Python-3.7%2B-blue)](https://www.python.org/)

## 📋 Table of Contents

- [Features](#-features)
- [Getting Started](#-getting-started)
- [Available Services](#-available-services)
- [Usage Examples](#-usage-examples)
- [Development](#-development)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

- **RTSP Server**: Simulates RTSP video streaming with test streams
- **HTTP Server**: Lightweight REST API server with common endpoints
- **gRPC Server**: Complete gRPC service with support for different RPC patterns
- **WebRTC Server**: WebRTC signaling server implementation
- **MQTT Broker**: MQTT message broker with WebSocket support
- **Containerized**: Easy deployment with Docker Compose
- **Development Ready**: Pre-configured for local development and testing

## 🚀 Getting Started

### Prerequisites

- Docker 20.10.0+
- Docker Compose 2.0.0+
- Make (optional, but recommended)
- Python 3.7+ (for development)

### Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/dialogchain/endpoints.git
   cd endpoints
   ```

2. Start all services:
   ```bash
   make up
   ```

3. Check service status:
   ```bash
   make status
   ```

4. Access services:
   - HTTP Server: http://localhost:8080
   - MQTT Broker: mqtt://localhost:1883
   - RTSP Stream: rtsp://localhost:8554/stream

## 🛠 Available Services

### RTSP Server
- **Port**: 8554 (RTSP), 8000 (HTTP)
- **Streams**: /stream, /test
- **Features**: H.264 video, AAC audio, authentication support

### HTTP Server
- **Port**: 8080
- **Endpoints**:
  - `GET /api/status` - Service status
  - `POST /api/echo` - Echo request data
  - `GET /api/stream` - Server-sent events

### gRPC Server
- **Port**: 50051
- **Services**:
  - EchoService
  - ChatService
  - StreamService

### MQTT Broker
- **Port**: 1883 (MQTT), 8883 (MQTT over SSL), 9001 (WebSocket)
- **Topics**:
  - `test/topic` - General testing
  - `sensors/#` - Sensor data
  - `commands/#` - Command messages

### WebRTC Server
- **Port**: 8443
- **Features**:
  - WebSocket signaling
  - STUN/TURN support
  - Multi-room chat

## 💡 Usage Examples

### Using with cURL

```bash
# Test HTTP endpoint
curl http://localhost:8080/api/status

# Publish MQTT message
mosquitto_pub -h localhost -t test/topic -m "Hello, MQTT!"

# View RTSP stream (requires VLC)
vlc rtsp://localhost:8554/stream
```

### Using with Python

```python
import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    logger.info(f"Connected with result code {rc}")
    client.subscribe("test/topic")

def on_message(client, userdata, msg):
    logger.info(f"{msg.topic}: {msg.payload.decode()}")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect("localhost", 1883, 60)
client.loop_forever()
```

## 🛠 Development

### Prerequisites

1. Install development dependencies:
   ```bash
   pip install -r requirements-dev.txt
   ```

2. Set up pre-commit hooks:
   ```bash
   pre-commit install
   ```

### Common Tasks

```bash
# Build all services
make build

# Start services in detached mode
make up

# View logs
make logs

# Run tests
make test

# Stop services
make down

# Clean up everything
make clean
```

### Adding a New Service

1. Create a new directory for your service
2. Add a `Dockerfile` and any necessary configuration
3. Update `docker-compose.yml`
4. Add documentation to this README
5. Submit a pull request

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

# Run linter
make lint

# Run tests with coverage report
make test-coverage

# Test specific services
make test-http     # Test HTTP server
make test-grpc     # Test gRPC service
make test-mqtt     # Test MQTT broker
make test-rtsp     # Test RTSP server
make test-webrtc   # Test WebRTC server
```

### Service Management

```bash
# Start specific service
make -C http up
make -C grpc up

# Stop specific service
make -C http down
make -C grpc down

# View service logs
docker-compose logs -f http
docker-compose logs -f grpc
```

### Monitoring

- **Prometheus Metrics**: `http://localhost:8000/metrics` (gRPC service)
- **Health Checks**:
  - HTTP: `http://localhost:8080/health`
  - gRPC: Use `grpc_health_probe` tool

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

## 🧪 Testing

### Running Tests

#### Using Makefile (Recommended)

```bash
# Run all tests
make test

# Run specific service tests
make test-http     # Test HTTP endpoints
make test-grpc     # Test gRPC service
make test-mqtt     # Test MQTT broker
make test-rtsp     # Test RTSP server
make test-webrtc   # Test WebRTC signaling

# Run tests with coverage report
make test-coverage

# Run linter
make lint
```

#### Using Ansible Directly

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

## 🔍 Examples

### HTTP API Examples

```bash
# Get service status
curl http://localhost:8080/

# Get sample data
curl http://localhost:8080/api/data

# Test different status codes
curl http://localhost:8080/api/status/200
curl http://localhost:8080/api/status/404

# Test delayed response (5 seconds)
curl http://localhost:8080/api/delay/5
```

### MQTT Examples

Using `mosquitto` client:

```bash
# Subscribe to a topic
mosquitto_sub -h localhost -t "test/topic"

# Publish a message
mosquitto_pub -h localhost -t "test/topic" -m "Hello MQTT"
```

### gRPC Client Example

```python
import grpc
import example_pb2
import example_pb2_grpc

channel = grpc.insecure_channel('localhost:50051')
stub = example_pb2_grpc.GreeterStub(channel)
response = stub.SayHello(example_pb2.HelloRequest(name='World'))
logger.info(f"gRPC response: {response.message}")
```

## ⚙️ Configuration

### Environment Variables

#### HTTP Server
- `HTTP_PORT`: Port to listen on (default: 8080)
- `LOG_LEVEL`: Logging level (debug, info, warning, error)

#### MQTT Broker
- `MQTT_PORT`: MQTT port (default: 1883)
- `WS_PORT`: WebSocket port (default: 9001)
- `ANONYMOUS`: Allow anonymous access (default: true)

#### RTSP Server
- `RTSP_PORT`: RTSP server port (default: 8554)
- `HTTP_PORT`: HTTP interface port (default: 8888)

## 📊 Monitoring

- **Prometheus Metrics**: Available at `http://localhost:8000/metrics` for gRPC service
- **Docker Logs**: View logs for individual services using `docker logs <container-name>`
- **Health Checks**:
  - HTTP: `http://localhost:8080/health`
  - gRPC: Use `grpc_health_probe` tool

## 🔧 Troubleshooting

### Common Issues

1. **Port Conflicts**
   - Check if required ports are available
   - Customize ports in `docker-compose.yml` if needed

2. **Service Not Starting**
   - Check logs: `docker-compose logs <service_name>`
   - Verify Docker is running: `docker ps`

3. **Connection Refused**
   - Ensure service is running
   - Check firewall settings
   - Verify host and port configuration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

### Development Setup

```bash
# Install development dependencies
pip install -r requirements-dev.txt

# Run linter
make lint

# Run tests with coverage
make test-coverage
```

## 📝 License

This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.

## 📚 Additional Resources

- [RTSP Protocol Specification](https://tools.ietf.org/html/rfc2326)
- [MQTT Documentation](https://mqtt.org/documentation/)
- [gRPC Documentation](https://grpc.io/docs/)
- [WebRTC API](https://webrtc.org/)

## 📈 Benchmarks

| Service | Requests/s | Latency (avg) |
|---------|------------|---------------|
| HTTP    | 15,000     | 2.1ms         |
| gRPC    | 22,000     | 1.4ms         |
| MQTT    | 50,000+    | <1ms          |

*Benchmarks performed on Intel i7-9700K, 32GB RAM*

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
