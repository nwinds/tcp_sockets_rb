require 'socket'
require 'timeout'

timeout = 5

Socket.tcp_server_loop(4481) do |connection|
	begin
		# start with a read(2) -- important
		connection.read_nonblock(4096)
	rescue Errno::EAGAIN
		# detect if there is an available connection
		if IO.select([connection], nil, nil, timeout)
			# IO.select will return socket, but what we care about is none nil means readable
			retry
		else
			raise Timeout::Error
		end
	end

	connection.close
end
