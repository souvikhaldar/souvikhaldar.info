---
title: "How to route entire traffic of iPhone and Macbook through Tor using Raspberry Pi"
date: 2021-07-14T16:10:03+05:30
draft: false
---
# Introduction
It should be trivial to understand by now that privacy and anonymity is an absolute must in the current age of everything being on the Internet, from the bank/school documents to personal photos to social media.  
Also, being on Tor network, unlocks the world of Dark web to be explored, which is bigger than all the websites a common person might have visited in a lifetime, called the surface web.  
Tor, The Onion Routing project, is the pioneer of freedom in the world of Internet.
Tor can be used to  

**Defend yourself against tracking and surveillance. Circumvent censorship**

Tor Relay Network is a great way of staying anonymous over the Internet because on this network the traffic gets directed through a free, community driven, overlay network consisting of 6 thousand relays.  

In this article I will explain how I used a Raspberry Pi to help route all the traffic on my iPhone through the Tor network, helping me secure my internet traffic on the device I use the most, from banking to social media!  

Also, I'll do the same for Macbook, which is the system on which I work!  

# Steps
Here, Raspberry Pi 3 would be used the proxy server through which the network is going to be routed.   

1. Setup the raspberry Pi in any preferred way, I would suggest installing Raspbian OS.  
2. Install `tor` using `sudo apt-get install tor`  
3. Configure tor:  
   Edit `torrc` file:
   1. `sudo vim /etc/tor/torrc`
   2. Most of the line would be commented out, but uncomment and make changes to the following lines:
	   `SocksPort 0.0.0.0:9100` 
	   You can configure SockPolicy, DataDirectory, etc as required.
   3. Now reload the configs using `sudo systemctl daemon-reload`
   4. Restart the service `sudo systemctl restart tor@default.service`
4. Now you can use tor on macbook easily configuring proxy option in the settings. This is going to be a socks5 proxy.  
	![Search for proxies in Preferences and update the socks5 proxy](/images/proxies.png)  
	
	If you want to setup tor routing only on Mac then you are good to go. You don't need to follow further steps. Now all of your traffic would be routed though the tor socks 5 proxy on the RPI which is present on your local network. (the IP of RPI is 192.168.0.106 and port is 9100 as set in step 3.2).
5. iPhone does not allow routing traffic though socks 5 proxy, hence we need a HTTP proxy on top of the tor socks 5 proxy. For that we will be using [polipo](https://www.irif.fr/~jch/software/polipo/) 
   1. Install polipo on pi using `sudo apt-get install polipo`
   2. Configure its config:
	   1. `sudo /etc/polipo/config`
	   2. Change the following items in the config:
	   ```
	   diskCacheRoot = " " # to avoid caching data on local system
	   allowedClients = 127.0.0.1, 192.168.0.0/24 # Expose your network (modify accordingly)
           socksParentProxy = "localhost:9100"
	   socksProxyType = socks5
           proxyAddress = "0.0.0.0"    # IPv4 only
	   ```
   3. Now you need to put IP of the RPI and port 8123 in the `manual` proxy setting. You can reach there by going to settings --> wifi --> select your connected wifi --> go to the bottom and click `Configure Proxy` --> Select `Manual` --> Save.
   
  ![Configure proxy on iPhone](/images/mobProxy.PNG)

# Conclusion
Now you are ready to explore internet with peace of mind that anonymity can provide. Please do cross check once that you were indeed able to configure tor well by visiting [this link](check.torproject.org) . You should ideally see something like this :)  

![Tor is configured successfully](/images/torConfirm.png)


   


	   

   



