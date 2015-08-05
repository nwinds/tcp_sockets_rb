# Ruby packing
require "socket"

# API
# server = Socket.new(:INET, :STREAM)
# addr = Socket.pack_sockaddr_in(4481, "0.0.0.0")
# server.bind(addr)
# server.listen(5)

# Ruby packing
server = TCPServer.new(4481)
# PS: Ruby initially set server.listen(5)(just 5 seconds)

# TCPServer#listen
server.listen(10)
