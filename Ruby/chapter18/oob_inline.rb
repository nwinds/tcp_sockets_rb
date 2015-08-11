require 'socket'

Socket.tcp_server_loop(4481) do |connection|
	# receive oob data alone with normal data IN band
	connection.setsockopt :SOCKET, :OOBINLINE, true

	# note: STOP reading data once receiving urgent data
	# my modification: 
	# I use p method to print out the result
	# 测试了一下（用中文写了……）
	# send 'xxxx', 0
	# send 'x', Socket::MSG_OOB
	# 两种方式是在不同批次被刷到readpartial里的
	p connection.readpartial(1024)
	p connection.readpartial(1024)

	# Q: why twice?
	# here is the output
	# $ ruby oob_inline.rb
	# "firstsecond"
	# "!"
end
