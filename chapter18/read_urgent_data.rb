require 'socket'

Socket.tcp_server_loop(4481) do |connection|
	IO.select(nil, nil, [connection])
	data = connection.readpartial(1024)
	p data
end

