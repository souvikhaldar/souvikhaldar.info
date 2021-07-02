---
title: "Enumeration using nmap"
date: 2021-06-02T10:50:24+05:30
draft: false
---
## Introduction

The de-facto standard for the first step in enumerating the target.  
Let's try to understand a few concepts.  

## Port scanning

### TCP connect scan -sT

If three-way handshake (SYN --> SYN ACK --> ACK) is complete on a TCP port, the port is considered open.
Port scanning on port range 3388-3390 using `netcat`:
`nc -nvv -w 1 -z 10.11.1.220 3388-3390`
Hence, if a port is OPEN, it will reply the incoming SYN request with SYN ACK request then the client will further send ACK to complete the handshake. But if the port is closed then the incoming SYN request is responded with a RST (reset) request. 
Now if the port is protected by a firewall, then the incoming SYN request is responded with nothing, hence indicating **filtered** port.  

### SYN scan -sS
In this kind of the scan, nmap sends a TCP SYN request just like the TCP connect scan, but when it receives the SYN ACK response, instead of sending back ACK request to complete the three way handshake, it send RST request and hence the handshake is never complete. That's why is it also called as *Half-open* scan.  
This is beneficial because it makes the scanning fast and also since the handshake is not complete hence this request does not get logged and detected by IDS too. But sometimes it can be problematic because the server might not handle such handshake.

### UDP scan -sU
Since UDP is stateless, hence three way handshake is not required before establishing the communication. Hence UDP port scanning is different from TCP port scanning.
Here, we send empty UDP packet to a port, the port, if open send the packet further to the application layer of OSI model and the response is crafted according to the application, but sometimes there is no response as well. But if the port is closed, we get ICMP *Port Unreachable* response.
UDP port scanning using `netcat`:
`nc -nv -w 1 -u -z 10.11.1.115 160-162`

## NULL -sN, FIN -sF and Xmas -sX scan
These three are stealthier scans.
NULL sends requests with no flag set and expects RST if is closed.  
Similarly, FIN sends requests FIN flag set which is used for closing active connection and expects RST if port is closed and Xmas sends malformed TCP packet with same expectation.
These are very good for firewall evasion.

## Measuring inbound and outbound traffic

We can measure the inbound and outbound traffic to and from a machine using `iptables`.
Set source:
`sudo iptables -I INPUT 1 -s <source-IP> -j ACCEPT`
Set destination:
`sudo iptables -I OUTPUT 1 -d 10.11.1.220 -j ACCEPT`

Zero the packet and byte counter before testing, by:
`sudo iptables -Z`

After doings tests (you can generate traffic using Nmap as well) you can check the statistics by:
`sudo iptables -vn -L`
(-n to enable numeric output, and -
L to list the rules present in all chains)

## Ping sweep
`Network Sweeping` is used to scan entire network for available machines. Use `-sn` flag in nmap.
nmap does host discovery using:

1.  `ICMP` echo request
2.  TCP SYN packet to 443
3.  TCP ACK to 80
4.  ICMP timestamp
Eg. `nmap -sn 192.168.0.1-254`


## quick tips

- For "greppable" nmap output use `-oG` flag.
- Use top twenty TCP ports with the --top-ports option and enable OS version detection, script scanning, and traceroute with -A  
- OS fingerprinting is guessing the OS of a machine by matching it's returned packets with set of OS patterns. Use `-O` flag.  
- Identify services running on specific ports by inspecting service banners ( -sV ) and
running various OS and service enumeration scripts ( –A ) against the target.  
- Nmap Scripting Engine (NSE) can launch user-created scripts in order to automate
various scanning tasks, using `--script` flag.  

### References
1.  [TryHackMe link](https://tryhackme.com/room/furthernmap)
2. PWK PDF
