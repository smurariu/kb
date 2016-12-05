Redirect DNS traffic that is neither to nor from the PiHole, to the PiHole

;;; redirect DNS to PiHole
chain=dstnat action=dst-nat to-addresses=192.168.88.5 protocol=udp src-address=!192.168.88.5 dst-address=!192.168.88.5 dst-port=53
chain=dstnat action=dst-nat to-addresses=192.168.88.5 protocol=tcp src-address=!192.168.88.5 dst-address=!192.168.88.5 dst-port=53

All DNS queries to PiHole shall appear to come from the router

;;; hairpin NAT for PiHole
chain=srcnat action=masquerade protocol=udp src-address=192.168.88.0/24 dst-address=192.168.88.5 dst-port=53
chain=srcnat action=masquerade protocol=tcp src-address=192.168.88.0/24 dst-address=192.168.88.5 dst-port=53