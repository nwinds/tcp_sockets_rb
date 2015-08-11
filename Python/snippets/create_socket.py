import socket

# create a socket(tcp protocol) for IPv4
sockIpv4 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# create a socket for IPv6
sockIpv6 = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)

