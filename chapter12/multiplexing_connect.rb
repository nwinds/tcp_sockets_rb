# connect_nonblock & Errno::EINPROGRESS

require 'socket'

socket = Socket.new(:INET, :STREAM)
remote_addr = Socket.pack_sockaddr_in(80, 'localhost')

begin
	socket.connect_nonblock(remote_addr)
rescue Errno::EINPROGRESS
	IO.select(nil, [socket])
	begin
		socket.connect_nonblock(remote_addr)
	rescue Errno::EISCONN
		# previous connection successed
	rescue Errno::ECONNREFUSED
		# refused by remote host
	# my impl for timeout case(google, GFW)
	rescue Errno::ETIMEDOUT
		puts 'timeout error'
	end
end
