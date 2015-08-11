# pseudo codes

for_reading = [<TCPSocket>, <TCPSocket>, <TCPSocket>]
for_writing = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

# add timeout
timeout = 10
IO.select(for_reading, for_writing, for_writing. timeout)

# IO.select check if any status changed in 10 secs
p ready 	# nil, if no status changed

