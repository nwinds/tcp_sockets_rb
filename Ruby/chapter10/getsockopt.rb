require 'socket'

socket = TCPSocket.new('qq.com', 80)
# get a Socket::Option
opt = socket.getsockopt(Socket::SOL_SOCKET, Socket::SO_TYPE)

# compare with int value in Socket:SOCK_STREAM
# I added p to print info
p opt.int == Socket::SOCK_STREAM
p opt.int == Socket::SOCK_DGRAM