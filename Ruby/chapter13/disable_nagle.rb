require 'socket'

server = TCPServer.new(4481)

# disable Nagle algorithm, tell server no delay, send immediatly
server.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

# my impl for checkout
p server.getsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY)
