# charpter 2
require "socket"
socket = Socket.new(:INET, :STREAM)
# create a c struct to save the listener addr
addr = Socket.pack_sockaddr_in(4481, "0.0.0.0")

# bind
socket.bind(addr)