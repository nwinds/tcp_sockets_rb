require 'socket'
require 'timeout'

socket = Socket.new(:INET, :STREAM)
remote_addr = Socket.pack_sockaddr_in(80, 'i.kamigami.org')
timeout = 0.01

begin
	socket.connect_nonblock(remote_addr)
rescue Errno::EINPROGRESS
	if IO.select(nil, [socket], nil, timeout)
		retry
	else
		raise Timeout::Error
	end

rescue Errno::EISCONN
	# connection is succeed
end

socket.write('ohai')
socket.close


