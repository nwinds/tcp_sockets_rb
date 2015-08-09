require 'socket'
require 'openssl'

# create TCP client socket
socket = TCPSocket.new('0.0.0.0', 4481)

ssl_socket = OpenSSL::SSL::SSLSocket.new(socket)
ssl_socket.connect

ssl_socket.read
