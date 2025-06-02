#!/usr/bin/env python3
import sys
import time
import requests
from dialogchain.utils.logger import setup_logger
logger = setup_logger(__name__)

def check_rtsp_server():
    try:
        # Try to access the RTSP server stats page
        response = requests.get('http://localhost:8888/stats', timeout=5)
        return response.status_code == 200
    except Exception as e:
        logger.info(f"Error checking RTSP server: {e}")
        return False

def main():
    print("Checking RTSP server status...")
    if not check_rtsp_server():
        print("❌ RTSP server is not running or not accessible")
        return False
    
    print("✅ RTSP server is running")
    print("Note: Stream verification requires OpenCV and is currently skipped")
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
