#
#psexec \\computer cmd -u domain\user -p password
#psexec -i is for interactive console on remote machine
#

# show current ipv4 address and interface alias
netsh int ipv4 show add

# set ipv4 address on interface "ethernet"

netsh int ipv4 set address "Ethernet" address=192.168.2.74 mask=255.255.255.0 gateway=192.168.2.92