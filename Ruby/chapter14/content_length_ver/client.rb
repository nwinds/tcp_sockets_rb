# chapter 14: devided by content length
# client

require 'socket'

module CloudHash
	class Client
		# improved ver: gets/puts support
		def initialize(host, port)
			@connection = TCPSocket.new(host, port)
		end

		def get(key)
			request 'GET %s' % key
		end

		def set(key, value)
			request 'SET %s %s' % [key, value]
		end

		# write then read
		def request(payload)
			begin
				# pack
				msg_length = payload.size
				packed_msg_length = [msg_length].pack('i')

				# write
				@connection.write(packed_msg_length)
				@connection.write(payload)
				# read
				@connection.read				
			rescue Errno::EPIPE
			end
		end
	end
end
				

								
# does 'localhost' also an API?
client = CloudHash::Client.new('localhost', 4481)

# set <key, value> pair
puts client.set 'prez', 'obama'
# get <value> from the pair using <key>
puts client.get 'prez'
# try fetching the <value> using different key
puts client.get 'vp'
# send exit signal
puts client.get 'exit'
