# pseudo codes

connections = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

# enter loop
loop do
	connections.each do |conn|
		begin
			# read_nonblock from every connection, handle
			# if EAGAIN, turn to next
			data = conn.read_nonblock(4096)
			# pseudo process code
			process(data)
		rescue Errno::EAGAIN
		end
	end
end
			
