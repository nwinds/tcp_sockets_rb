# pseudo codes
connections = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

# enter loop
loop do
	# consulting which connection is available
	ready = IO.select(connections)

	# read from availables
	readable_connections = ready[0]
	readable_connections.each do |conn|
		# begin
			data = conn.read_nonblock(4096)
			process(data)
		# rescue Errno::EAGAIN
		# end
	end
end
			
