import pinggy

# Start an HTTP tunnel forwarding traffic to localhost on port 8000
tunnel = pinggy.start_tunnel(forwardto="localhost:8000")

print(f"Tunnel started. Urls: {tunnel.urls}")
