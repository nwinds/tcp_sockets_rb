# Ruby packing
require "socket"

# return 2 sockets: one for IPv4 and the other for IPv6
servers = Socket.tcp_server_sockets(4481)

# $ sudo: unable to resolve host ipr
# tcp        0      0 *:4481                  *:*                     LISTEN      14317/ruby      
# tcp6       0      0 [::]:4481               [::]:*                  LISTEN      14317/ruby  

# -> only ONE task(thread)

# Socket.accept_loop: accept every sockets's connection
Socket.accept_loop(servers) do |connection|
	connection.close
end
