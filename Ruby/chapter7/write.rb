require 'socket'
Socket.tcp_server_loop(4481) do |connection|
	# simplest way to write data in
	connection.write('Hello Socket\n')
	connection.close
end
