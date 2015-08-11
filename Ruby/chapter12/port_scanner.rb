# simple port scanner
require 'socket'

PORT_RANGE = 1..128
host = 'i.kamigami.org'
TIME_OUT_WAIT = 5

# create a socket for every port and connect_nonblock
sockets = PORT_RANGE.map do |port|
	socket = Socket.new(:INET, :STREAM)
	remote_addr = Socket.pack_sockaddr_in(port, 'i.kamigami.org')

	begin
		# adjust: will ALWAYS quit
		# so in order to... at least connect it, I will use connect
		socket.connect_nonblock(remote_addr)
		# debug
		p "connected: #{port}, #{socket}"
	rescue Errno::EINPROGRESS
		# p "in progress: #{socket}"
		# Will never happen: cause this is connect_nonblock!
		# rescue Errno::ETIMEDOUT
		# 	p '=> rescue from timeout'
	rescue Errno::EALREADY
		puts 'already in connection'
	end
	# p socket.remote_address

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
			puts '%s:%d  accepts connections...' % [host, socket.remote_address.ip_port]
			# remove socket(successfully connected), so that it won't be selected again
			sockets.delete(socket)
		rescue Errno::EINVAL
			sockets.delete(socket)
		# my impl to avoid Error reported
		rescue Errno::ENOTCONN
			sockets.delete(socket)
		end
	end
end
		
	