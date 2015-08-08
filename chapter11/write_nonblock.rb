extrequire 'socket'

client = TCPSocket.new('localhost', 4481)
payload = 'Lorem ipsum' * 10_000

written = client.write_nonblock(payload)
p written >= payload.size
