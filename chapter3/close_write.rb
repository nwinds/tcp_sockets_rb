require "socket"

# create server's
server = Socket.new(:INET, :STREAM)
addr = Socket.pack_sockaddr_in(4481, '0.0.0.0')
server.bind(addr)
server.listen(128)
connection, _ = server.accept

# this connection may not need write, but read is needed
connection.close_write
# Q: how can I print out current user permission(like r, r/w?)
# no more r/w
connection.close_read
