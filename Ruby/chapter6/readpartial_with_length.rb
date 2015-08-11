require 'socket'

one_hundred_kb = 1024 * 100 # 1024 bytes

Socket.tcp_server_loop(4481) do |connection|
	begin
		# read in <=100KB per time
		while data = connection.readpartial(one_hundred_kb) do
			puts data
		end
		
	rescue EOFError
	end

	connection.close
end
