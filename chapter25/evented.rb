# event.rb

require 'socket'
require_relative '../chapter19/command_handler'

module FTP
	class Evented
		CHUNK_SIZE = 1024 * 16

		# 
		class Connection
			CRLF = '\r\n'
			attr_reader :client

			def initialize(io)
				@client = io
				@request, @response = '', ''
				@handler = CommandHandler.new(self)

				respond '220 OHAI'
				on_writable
			end

			def on_data(data)
				@request << data

				if @request.end_with?(CRLF)
					# finish with request
					respond @handler.handle(@request)
					@request = ''
				end
			end

			def respond(message)
				@response << message + CRLF

				# load writable immediatly
				# the rest can retry while socket writable next time
				on_writable
			end

			def on_writable
				bytes = client.write_nonblock(@response)
				@response.slice!(0, bytes)
			end

			def monitor_for_reading?
				true
			end

			def monitor_for_writing?
				!(@response.empty?)
			end
		end

		def initialize(port = 21)
			@control_socket = TCPServer.new(port)
			trap(:INT){ exit }
		end

		def run
			@handles = {} # the nameing: handler, handle, handles: confusiong!

			loop do
				to_read = @handles.values.select(&:monitor_for_reading?).map(&:client)
				to_write = @handles.values.select(&:monitor_for_writing?).map(&:client)

				readables, writables = IO.select(to_read + [@control_socket], to_write)

				readables.each do |socket|
					if socket == @control_socket
						io = @control_socket.accept
						# why packup connection in Connection class, 
						# while copying all things using CommandHandler
						# (note, you can use Class method instead of object'e method in Ruby)
						# => see the explain in my notes(chapter 25)
						connection = Connection.new(io)
						@handles[io.fileno] = connection
						
					else
						connection = @handles[socket.fileno]
						
						begin
							data = socket.read_nonblock(CHUNK_SIZE)
							connection.on_data(data)
						rescue Errno::EAGAIN
						rescue EOFError
							@handles.delete(socket.fileno)
						end
					end
				end

				writables.each do |socket|
					connection = @handles[socket.fileno]
					connection.on_writable
				end
			end
		end
	end
end

server = FTP::Evented.new(4481)
server.run
