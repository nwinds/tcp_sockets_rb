# server
require 'socket'

module CloudHash
	class Server		
		def initialize(port)
			# ruby packed server socket
			@server = TCPServer.new(port)  
			puts 'Listening on port #{@server\.local_address\.ip_port}' 
			@storage = {}
		end
		
		def start
			# ruby packed accept loop
			Socket.accept_loop(@server) do |connection|
				handle(connection)  # helper for connection r/w
				connection.close
			end
		end

		# read then write
		def handle(connection)
			# read until EOF
			request = connection.read
			# write back hash operation result
			# process - helper for hashing
			connection.write process(request)
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

