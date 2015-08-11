require 'socket'

one_kb = 1024 # 1024 bytes

# loop forever
Socket.tcp_server_loop(4481) do |connection|
	# read data in 1KB unit
	while data = connection.read(one_kb) do
		puts data
	end

	connection.close
end
