import socket
import sys
import bpy

HOST = '127.0.0.1'
PORT = 65435

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))

# listen() marks the socket referred to by sockfd as a passive socket (awaits for an in­coming connection,
# which will spawn a new active socket once a connection is established), that is, as a socket that
# will be used to accept incoming connection requests using accept(2).
s.listen()

# Extracts the first connection request on the queue of pending connections for the listening socket,
# sockfd, creates a new connected socket, and returns a new file descriptor referring to that socket.
# The newly created socket is not in the listening state. The original socket sockfd is unaffected by
# this call.
conn, addr = s.accept()
conn.settimeout(0.0)


def handle_data():
    interval = 0.1
    #print('Connected by: ', addr)
    data = None

    # In non-blocking mode blocking operations error out with OS specific errors.
    # https://docs.python.org/3/library/socket.html#notes-on-socket-timeouts
    try:
        data = conn.recv(1024)
    except:
        pass

    if not data:
        pass
    else:
        conn.sendall(data)
       
        # Fetch the 'Sockets' collection or create one. Anything created via sockets will be linked
        # to that collection.
        collection = None
        try:
            collection = bpy.data.collections["Sockets"]
        except:
            collection = bpy.data.collections.new("Sockets")
            bpy.context.scene.collection.children.link(collection)

        if "quit" in data.decode("utf-8"):
            conn.close()
            s.close()

        else:
            decoded_data = data.decode("utf-8")
            eval(decoded_data)

    return interval

bpy.app.timers.register(handle_data)