require 'socket'

Socket.tcp_server_loop(4481) do |connection|
	# receiving oob data first
	# note: if receiver don't use recv, then it will not notice the oob data
	urgent_data = connection.recv(1, Socket::MSG_OOB)
	
	data = connection.readpartial(1024)
end
# if no oob data unhandled:
# in `recv': Invalid argument - recvfrom(2) (Errno::EINVAL)
