require "socket"

socket = Socket.new(:INET, :STREAM)

remote_addr = Socket.pack_sockaddr_in(70, 'qq.com')
socket.connect(remote_addr)
