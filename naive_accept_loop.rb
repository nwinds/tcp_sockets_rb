require "socket"

# create server's
server = Socket.new(:INET, :STREAM)
addr = Socket.pack_sockaddr_in(4481, '0.0.0.0')
server.bind(addr)
server.listen(12)

# accept connection and handle
# an endless loop
loop do
	connection, _ = server.accept
	connection.close
end
