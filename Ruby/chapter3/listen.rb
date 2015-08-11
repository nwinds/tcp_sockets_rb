require "socket"

# create socket and bind to port 4481
socket = Socket.new(:INET, :STREAM)
addr = Socket.pack_sockaddr_in(4481, '0.0.0.0')
socket.bind(addr)

#let socket know the connection to listen
socket.listen(5)