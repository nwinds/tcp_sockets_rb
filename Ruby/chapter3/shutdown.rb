require "socket"

# create server's
server = Socket.new(:INET, :STREAM)
addr = Socket.pack_sockaddr_in(4481, '0.0.0.0')
server.bind(addr)
server.listen(128)
connection, _ = server.accept

# create duplication of connection
copy = connection.dup

# close every duplication of connection
connection.shutdown

# close original connection itself. duplication will be collected by gargabe colleter
connection.close

# Q: how can I trace all these?