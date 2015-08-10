# thread_per_connection.rb
require 'socket'
require 'thread'

require_relative '../chapter19/command_handler'

module FTP
	Connection = Struct.new(:client) do
		CRLF = '\r\n'
		
		def gets
			@client.gets(CRLF)
		end

		def respond(message)
			# begin
				@client.write(message)
				@client.write(CRLF)
			# rescue NoMethodError
			# end
		end

		def close
			client.close
		end
	end

	class ThreadPerConnection
		# port 21 is for FTP
		def initialize(port = 21)
			@control_socket = TCPServer.new(port)
			# exit if interrupt
			trap(:INT) { exit }
		end


		def run
			Thread.abort_on_exception = true
			loop do
				conn = Connection.new(@control_socket.accept)
			Thread.new do
				conn.respond '220 OHAI'
				handler = FTP::CommandHandler.new(conn)

				loop do
					# Q: @conn or conn?
					request = conn.gets

					if request
						conn.respond handler.handle(request)
					else
						conn.close
						break
					end
				end
			end
			end
		end
	end
end

server = FTP::ThreadPerConnection.new(4481)
server.run