require 'socket'

socket = TCPSocket.new 'localhost', 4481

# send data using standard method
socket.write 'first'
socket.write 'second'
socket.send 'third', 0
# send urgent data
# TCP: only the last byte can be regarded as urgent data, 
# and only one byte can be
socket.send '!', Socket::MSG_OOB

