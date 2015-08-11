require 'socket'

# loop endlessly
Socket.tcp_server_loop(4481) do |connection|
	# simplest way to fetch data from connection
	puts connection.read
	# close connection if finish, let client knoe it not required to wait till data return
	connection.close
end

# run
# $ tail -f /var/log/system.log | nc localhost 4481
# I use
# $ sudo lsof -nP -iTCP:4481 -sTCP:LISTEN
# Password:
# COMMAND PID USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
# ruby    734  xxx    8u  IPv4 0x37e10f80eec57b57      0t0  TCP *:4481 (LISTEN)
# ruby    734  xxx    9u  IPv6 0x37e10f80e927df17      0t0  TCP *:4481 (LISTEN)
# $ kill 734
