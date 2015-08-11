# chapter 14: devided by content length
# server
require 'socket'

# 8/9/15 review: 
# (if client sent too much data)
# may cause system interrupt to wait for data, and very slow!

module CloudHash
	SIZE_OF_INT = [11].pack('i').size

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
		def handle(connection)
			# pack : convert message's length into a sized int, then read and unpack
			packed_msg_length = connection.read(SIZE_OF_INT)
			msg_length = packed_msg_length.unpack('i').first
			# read in length fixed message
			request = connection.read(msg_length)

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

