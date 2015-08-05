# Ruby packing
require "socket"

# GRIANT Ruby pack
# Socket.tcp_server_loop: a packer of Socket.accept_loop and Socket.tcp_server_sockets
Socket.tcp_server_loop(4481) do |connection|
	connection.close
end

