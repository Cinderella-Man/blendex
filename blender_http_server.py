import bpy
from http.server import BaseHTTPRequestHandler, HTTPServer
import logging

keep_looping=True

class S(BaseHTTPRequestHandler):
    def _set_response(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        self._set_response()
        self.wfile.write("GET not supported".encode('utf-8'))

    def do_POST(self):
        content_length = int(self.headers['Content-Length']) # <--- Gets the size of data
        post_data = self.rfile.read(content_length).decode('utf-8') # <--- Gets the data itself
        self._set_response()
        if post_data.strip() == "quit":
            global keep_looping
            keep_looping = False
            self.wfile.write("Stopping server".format(self.path).encode('utf-8'))
            logging.info('Stopping httpd...\n')            
        else:
            self.wfile.write("POST request for {}".format(self.path).encode('utf-8'))
            self.wfile.write("POST request,\nPath: {}\nHeaders:\n{}\n\nBody:\n{}\n".format(str(self.path), str(self.headers), post_data).encode('utf-8'))
            exec(post_data)

def run(server_class=HTTPServer, handler_class=S, port=8080):
    logging.basicConfig(level=logging.INFO)
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    logging.info('Starting httpd...\n')
    while keep_looping:
        httpd.handle_request()

run()