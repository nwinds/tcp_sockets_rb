# chapter 14: devided by newline
# server
require 'socket'

# 8/9/15 review: 
# (if client sent too much data)
# may cause system interrupt to wait for data, and very slow!

module CloudHash
	class Server		
		def initialize(port)
			# ruby packed server socket
			@server = TCPServer.new(port)  
			puts 'Listening on port %d' % @server.local_address.ip_port 
			@storage = {}
		end
		
		def start
			# ruby packed accept loop
			Socket.accept_loop(@server) do |connection|
				handle(connection)  # helper for connection r/w
				connection.close
			end
		end

		# upgraded guided chapter 14
		# read then write => gets then puts
		# use $ ri <func_name> to see detailed info
		def handle(connection)
			loop do
				request = connection.gets
				break if request == 'exit'
				begin
					connection.puts process(request)				
				rescue NoMethodError
				end
			end
		end

		# cmd supported
		# SET key value
		# GET key
		def process(request)
			command, key, value = request.split
			case command.upcase
			when 'GET'
				@storage[key]
			when 'SET'
				@storage[key] = value
			end
		end
	end
end

server = CloudHash::Server.new(4481)
server.start

