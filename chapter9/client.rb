# client
require 'socket'
module CloudHash
	class Client
		class << self
			attr_accessor :host, :port
		end

		def self.get(key)
			request 'GET #{key}'
		end

		def self.set(key, value)
			request 'SET #{key} #{value}'
		end

		# write then read
		def self.request(string)
			# create a new connection for each request(not a good way, which will be discussed later in the guide book)
			@client = TCPSocket.new(host, port)
			@client.write(string)
			# send EOF
			# if not: ESTABLISHED
			@client.close_write
			# read until EOF
			@client.read
			# Q: why first write then read?
		end
	end
end

# does 'localhost' also an API?
CloudHash::Client.host = 'localhost'
CloudHash::Client.port = 4481

puts CloudHash::Client.set 'prez', 'obama'
puts CloudHash::Client.get 'prez'
puts CloudHash::Client.get 'vp'

