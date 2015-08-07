# read_nonblock.rb
require 'socket'

Socket.tcp_server_loop(4481) do |connection|
	loop do
		begin
			puts connection.read_nonblock(4096)
		rescue Errno::EAGAIN
			# instead of simply retry for reading in an nonblock way
			IO.select([connection])
			retry
		rescue EOFError
			break
		end
	end

	connection.close
end

