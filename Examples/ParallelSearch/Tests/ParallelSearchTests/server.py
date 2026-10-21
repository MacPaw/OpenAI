"""Local MCP HTTP fixture that retains headers observed on the wire."""
import json
import signal
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

log_path, tools_mode, call_mode = sys.argv[1:]
requests = []
# Swift's Linux test runner may launch children with SIGTERM blocked.
signal.pthread_sigmask(signal.SIG_SETMASK, [])


class Handler(BaseHTTPRequestHandler):
    def log_message(self, *args):
        pass

    def do_POST(self):
        body = json.loads(self.rfile.read(int(self.headers["Content-Length"])))
        requests.append({"path": self.path, "method": "POST",
                         "headers": {k.lower(): v for k, v in self.headers.items()}, "body": body})
        Path(log_path).write_text(json.dumps(requests))
        if "id" not in body:
            self.send_response(202)
            self.end_headers()
            return
        method = body["method"]
        if method == "initialize":
            result = {"protocolVersion": "2025-03-26", "capabilities": {"tools": {}},
                      "serverInfo": {"name": "fixture", "version": "1"}}
        elif method == "tools/list":
            names = ["web_search"] if tools_mode == "missing" else ["web_search", "web_fetch", "unrelated_tool"]
            result = {"tools": [{"name": name, "description": name, "inputSchema": {"type": "object"}} for name in names]}
        elif method == "tools/call":
            result = {"content": [{"type": "text", "text": "fixture failure" if call_mode == "error"
                                   else "Swift documentation: https://www.swift.org/documentation/"}],
                      "isError": call_mode == "error"}
        else:
            raise AssertionError(method)
        data = json.dumps({"jsonrpc": "2.0", "id": body["id"], "result": result}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


server = HTTPServer(("127.0.0.1", 0), Handler)
print(f"http://127.0.0.1:{server.server_port}/mcp", flush=True)
server.serve_forever()
