---
title: "How to route entire traffic of iPhone and Macbook through Tor using Raspberry Pi"
date: 2021-07-14T16:10:03+05:30
draft: false
---
# Introduction
It should be trivial to understand by now that privacy and anonymity is absolute must in the current age of everything being on the Internet, from the bank/school documents to personal photos to social media.  
Also, being on Tor network, unlocks the world of Dark web to be explored, which bigger than all the websites a common person might have visited in a lifetime, called the surface web.  
Tor, The Onion Routing project, is the pioneer of freedom in the world of Internet.
Tor can be used to:  
>Defend yourself against tracking and surveillance. Circumvent censorship

Tor Relay Network is a great way of staying anonymous over the Internet because on this network the traffic gets directed through a free, community driven, overlay network consisting of 6 thousand relays.  

In this article I will explain how I used a Raspberry Pi to help route all the traffic on my iPhone though the Tor network, helping me secure my internet traffic on the device I use the most, from banking to social media!  

Also, I'll do the same for Macbook, which is the system on which I work!  

# Steps
Here, Raspberry Pi 3 would be used the proxy server though which the network is going to be routed.   

1. Setup the raspberry Pi in any preferred way, I would suggest installing Raspbian OS.  
2. Install `tor` using `sudo apt-get install tor`  
3. [ ] Configure tor:  
   Edit `torrc` file:
   1. `sudo vim /etc/tor/torrc`
   2. Most of the line would be commented out, but uncomment and make changes to the following lines:
	   `SocksPort 0.0.0.0:9100` 
	   You can configure SockPolicy, DataDirectory, etc as required.
   3. Now reload the configs using `sudo systemctl daemon-reload`
   4. Restart the service `sudo systemctl restart tor@default.service`
4. Now you can use tor on macbook easily configuring proxy option in the settings. This is going to be a socks5 proxy.  
	[Search for proxies in Preferences and update the socks5 proxy](/images/proxies.png)
   


	   

   



