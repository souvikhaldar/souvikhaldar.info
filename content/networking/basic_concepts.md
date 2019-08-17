---
title: "Basic Concepts of Computer Networking"
date: 2019-08-17T21:33:47+05:30
draft: false
---

# What is a Computer Network
A communication system for connecting internet-enabled devices like computers,smartphones,etc.  

# Types of Computer Networks 
Broadly classified into two groups:-
1) Local Area Network (LAN):  
    *  Connects hosts within a relatively small geographical area, like same room, same building, same campus,etc.  
    *  Faster.  
    *  Cheaper.  
2) Wide Area Network (WAN):  
    *  Connects hosts in relatively bigger geographical area, like a city, a country, a continent, etc.  
    *  Slower  
    *  Expensive  

The initial cost of setting up a LAN might be high, but the end result is a self managed network infrastructure. Whereas, in WAN there is no investment for setup and ISP (Internet Service Provider) takes care of the maintenance, but eventually we end up paying hefty for the maintenance over the time. Hence WAN is relatively cheaper than LAN.  

# Types of Data Communication  
## 1) Circuit Switching  
When two nodes want to communicate with each other in **Circuit Switching**, a dedicated path is established between them. A ****logical channel**** is defined on this established path, where **logical channel** means a chanel of fixed bandwidth on this path. So, the given path might be shared by other communicating nodes, but the **logical channel** based on this path guarantees a network of fixed bandwidth.  
Steps involved in the process:  
    (a) **Setting up of the path**: This needs to done before data transfer can take   place.  
    (b) **Data transfer**: The best thing about **circuit switching** is that data transfer happens at the maximum speed possible.  
    (c) **Termination**: Termination of the connection once the data transfer is done.  

Cons:  
*  **Inefficient useage for bursty traffic**: The reserved bandwidth might be underutilized for the cases where the flow of data is not consistent.  
*  **Initial Delay**: There is a delay at the initial stage due to the process of setting up a dedicated path and then channel.  

## 2) Packet Switching  
When two nodes need to communicate between each other, no dedicated path is setup, instead all links are shared. It is the modern form of communication.     
Steps:  
1) The message is broken down into smaller chunks called, packets. Each packet is comprised of two parts, the **header** part where the metadata is stored and the **data** part where the data is stored.  
2) The transfer of packets follows **store and forward** concept. In this concept, each intermediate node (router) stores the packets and forwards to further nodes on suitable conditions. To decide which node to forward to next, each router maintains a **routing table**.  
Pros:  
*  Links are shared so the utilization is always good.  
*  Packets can be forwarded according to set priority.   

### How are these packets transmitted?  
1) Virtual Circuit:  
It is similar to Circuit-switching, as in, it also sets up a path (not dedicated though) for the packet transfer to happen.  
In this case, each packets contains the **Virtual-circuit number** in the header part. The routing table in the routers follows this virtual-circuit number of the packets and forwards accordingly. Hence no dynamic decisions are taken by the routers and all packets follow a predetermined path.
2) Datagram

