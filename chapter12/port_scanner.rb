# simple port scanner
require 'socket'

PORT_RANGE = 1..128
HOST = 'localhost'
TIME_OUT_WAIT = 5

# create a socket for every port and connect_nonblock
sockets = PORT_RANGE.map do |port|
	socket = Socket.new(:INET, :STREAM)
	remote_addr = Socket.pack_sockaddr_in(port, HOST)

	begin
		socket.connect_nonblock(remote_addr)
	rescue Errno::EINPROGRESS
	end
	
	socket
end

expiration = Time.now + TIME_OUT_WAIT

loop do
	# every time IO.select is called, renew the timeout, so that timeout will never triggered
	_, writable, _ = IO.select(nil, sockets, nil, 5)
	break unless writable

	writable.each do |socket|
		begin
			socket.connect_nonblock(socket.remote_address)
		rescue Errno::EISCONN
			puts '#{HOST}:#{socket.remote_address.ip_port} accepts connections...'
			# remove socket(successfully connected), so that it won't be selected again
			sockets.delete(socket)
		# my impl for not connected exception
		rescue Errno::ENOTCONN
		end
	end
end
		
	