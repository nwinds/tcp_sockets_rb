require 'socket'
require 'timeout'

server = TCPServer.new(4481)
timeout = 5

begin
	server.accept_nonblock
rescue Errno::EAGAIN
	if IO.select([server], nil, nil, timeout)
		retry
	else
		raise Timeout::Error
	end
end

server.close
