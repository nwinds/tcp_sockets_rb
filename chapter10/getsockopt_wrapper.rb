# ruby wrappered getsockopt demo
require 'socket'

socket = TCPSocket.new('qq.com', 80)
# use ruby pack instead of const
opt = socket.getsockopt(:SOCKET, :TYPE)

p opt.int == Socket::SOCK_STREAM
p opt.int == Socket::SOCK_DGRAM