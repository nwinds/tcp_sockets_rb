# Ruby packing
require "socket"

# return 2 sockets: one for IPv4 and the other for IPv6
# both listening the 4481 port
servers = Socket.tcp_server_sockets(4481)

