# pseudo codes

for_reading = [<TCPSocket>, <TCPSocket>, <TCPSocket>]
for_writing = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

# <read Array> <write Array> <oob data Array>
# oob: out-of-band data
IO.select(for_reading, for_writing, for_writing)
