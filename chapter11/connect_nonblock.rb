require 'socket'

socket = Socket.new(:INET, :STREAM)
remote_addr = Socket.pack_sockaddr_in(80, 'qq.com')
# loop_time = 1..1024
# loop_time.each do
	begin
		# nonblock connect to port 80
		socket.connect_nonblock(remote_addr)
	rescue Errno::EINPROGRESS
		p 'in progress'
		# opt going
	rescue Errno::EALREADY
		p 'already connected'
		# previous nonblock connection already going
	rescue Errno::ECONNREFUSED
		p 'connect refused'
		# remote host refuse connect	
	end
# end
