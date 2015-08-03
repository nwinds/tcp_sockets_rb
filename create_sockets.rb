# chapter 1

# create_sockets.rb
require "sockets"

# IPv4
socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)
# actually similar to c: just get you know API
# INET: internet, for IPv4 sockets

# create_sockets_memoized.rb
# IPv6
# syntactic sugar
socket = Socket.new(:INET6, :STREAM)


