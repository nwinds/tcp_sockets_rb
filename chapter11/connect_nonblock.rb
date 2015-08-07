require 'socket'

socket = Socket.new(:INET, :STREAM)
remote_addr = Socket.pack_sockaddr_in(4481, 'localhost')

begin
	# nonblock connect to port 80
	socket.connect_nonblock(remote_addr)
rescue Errno::EINPROGRESS
	# opt going
rescue Errno::EALREADY
	# previous nonblock connection already going
rescue Errno::ECONNREFUSED
	# remote host refuse connect	
end
