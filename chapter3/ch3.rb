# loopback_binding.rb
require 'socket'

# listen from localhost's client
local_socket = Socket.new(:INET, :STREAM)
local_addr = Socket.pack_sockaddr_in(4481, '127.0.0.1')
local_socket.bind(local_addr)

# listen from all hosts 
# note what the 'in' means
any_socket = Socket.new(:INET, :STREAM)
any_addr = Socket.pack_sockaddr_in(4481, '0.0.0.0')
any_socket.bind(any_addr)

# trigger an Errno::EADDRNOTAVAIL
# Q: why the 1.2.3.4 is *unknown* ?
error_socket = Socket.Socket.new(:INET, :STREAM)
error_addr = Socket.pack_sockaddr_in(4481, '1.2.3.4')
error_socket.bind(error_addr)
