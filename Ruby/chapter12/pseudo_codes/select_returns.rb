# pseudo codes

for_reading = [<TCPSocket>, <TCPSocket>, <TCPSocket>]
for_writing = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

IO.select(for_reading, for_writing, for_writing)

# for each passed in return an Array
p ready 	# [[<TCPSocket>], [], []]
