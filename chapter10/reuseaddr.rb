require 'socket'

server = TCPServer.new('localhost', 4481)
server.setsockopt(:SOCKET, :REUSEADDR, true)

# I use p to print out result
p server.getsockopt(:SOCKET, :REUSEADDR)