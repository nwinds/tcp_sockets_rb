require "socket"

Socket.tcp("qq.com", 80) do |connection|
	connection.write"GET / HTTP/1.1\r\n"
	connection.close
end

# implicitly(without the write XXX block), same with TCPSocket.new()
client = Socket.tcp("qq.com", 80)
