# chapter 14: devided by newline
# client

require 'socket'

module CloudHash
	class Client
		# class << self
		# 	attr_accessor :host, :port
		# end

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
		def request(string)
			# create a new connection for each request
			@connection.puts(string)
			# read untill recieving new line reply
			@connection.gets
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
