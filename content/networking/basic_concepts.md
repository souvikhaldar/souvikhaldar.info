---
title: "Basic Concepts of Computer Networking"
date: 2019-08-17T21:33:47+05:30
draft: false
---

# What is a Computer Network
A communication system for connecting internet-enabled devices like computers,smartphones,etc.  

# Types of Computer Networks 

### Local Area Network (LAN):  
*  Connects hosts within a relatively small geographical area,like same room, same building, same campus,etc.  
*  Faster.  
*  Cheaper.  

### Wide Area Network (WAN):  
*  Connects hosts in relatively bigger geographical area, like a city, a country, a continent, etc.  
*  Slower  
*  Expensive  

The initial cost of setting up a LAN might be high, but the end result is a self managed network infrastructure. Whereas, in WAN there is no investment for setup and ISP (Internet Service Provider) takes care of the maintenance, but eventually we end up paying hefty for the maintenance over the time. Hence WAN is relatively cheaper than LAN.  

# Types of delay in communication  
1) Propagation Delay- Time required by the packet to propagate from the source to destination in the given medium, hence it is dependent on the type of the medium.  
2) Transmission Delay- Time taken by the transmitter to transmit the packets. It depends on the bandwidth and size of the packets.  
3) Processing Delay- Time taken by the nodes to forward the packets. Since nodes store and forward the packets, hence there is some delay there.  

# Types of Data Communication  

### 1) Circuit Switching  
When two nodes want to communicate with each other in **Circuit Switching**, a dedicated path is established between them. A **logical channel** is defined on this established path, where **logical channel** means a chanel of fixed bandwidth on this path. So, the given path might be shared by other communicating nodes, but the **logical channel** based on this path guarantees a network of fixed bandwidth.  
Steps involved in the process:  
    *  **Setting up of the path**: This needs to done before data transfer can take   place.  
    *  **Data transfer**: The best thing about **circuit switching** is that data transfer happens at the maximum speed possible.  
    *  **Termination**: Termination of the connection once the data transfer is done.  

Cons:  
*  **Inefficient useage for bursty traffic**: The reserved bandwidth might be underutilized for the cases where the flow of data is not consistent.  
*  **Initial Delay**: There is a delay at the initial stage due to the process of setting up a dedicated path and then channel.  

### 2) Packet Switching  
When two nodes need to communicate between each other, no dedicated path is setup, instead all links are shared. It is the modern form of communication.     
Steps:  
1) The message is broken down into smaller chunks called, packets. Each packet is comprised of two parts, the **header** part where the metadata is stored and the **data** part where the data is stored.  
2) The transfer of packets follows **store and forward** concept. In this concept, each intermediate node (router) stores the packets and forwards to further nodes on suitable conditions. To decide which node to forward to next, each router maintains a **routing table**.  
Pros:  
*  Links are shared so the utilization is always good.  
*  Packets can be forwarded according to set priority.   


#### How are these packets transmitted?  
1) Virtual Circuit approach:  
It is similar to Circuit-switching, as in, it also sets up a path (not dedicated though) for the packet transfer to happen. Initially, a `Call Request` packet is sent from the source to destination. Once it reaches successfully, a `Call Accept` packet is sent back in the form of acknowledgement and hence the routing table in the nodes in made.   
In this case, each packets contains the **Virtual-circuit number** in the header part. The routing table in the routers follows this virtual-circuit number of the packets and forwards accordingly. Hence no dynamic decisions are taken by the routers and all packets follow a predetermined path.  
2) Datagram approach:  
Unlike `Virtual Circuit` approach, in `Datagram` approach no route is fixed before the communication can begin, hence there is no time delay for path setup (happens in the beginning) and termination. Communication in `Virtual Circuit` approach is generally faster if the number of packets is less, however if the number of the packets is huge `Virtual Circuit` approach may be faster due to dedicated channel of communication.  
Every packet is independent and the header of every packet contains the source address and destination address along with other information. Since there is no dedicated path established beforehand, every node is responsible for routing the packets by making dynamic decisions and maintains a `routing table`, hence it can handle congestion and link failure.  
On the downside, `Vitual Circuit` approach does not guarantee delivery of every packet and packets are often delivered in random order, just like our postal system, since every packet is independent. Also, if a node crashes, all the data stored in the node gets lost!

# Layered Network Architecture  
The Open Systems Interconnection (OSI) model is a seven layer model which is used to describe the hierarchical layers of the network. The objective of this model is clearly design the network and make each layer of this model independent of other layers i.e changes to one layer does not affect the other.   

{{< tweet 1137991622178816001 >}}  
An easy way to remember this stack is:  
```
Please
Do
Not
Throw
Sausage
Pizza
Away
```

Of the above seven layers, the last three (i.e Physical, Data Link and Network) are found in the source and destination nodes and the intermediate nodes of communication, i.e **Point to Point** connection between the nodes. But the four layers above them (i.e Transport,Session, Presentation and Application) are found in the source and destination host only and are hence **host-to-host**.  
**Physical** layer is the physical medium of transportation of data, **Data Link** is where reliable transfer of the frames (packet converted to frame here) between the nodes takes place (flow control, error control,etc) and the **Network** layer is responsible for routing of the frames across the network.  
**Transport** layers is responsible to reliable communication, **Session** layer manages the session of the communication, **Presentation** is the optional layers of typically conversion of data takes place (like encryption,code conversion,etc) and finally **Application** is the layer which interfaces with the user.  

**This is how the data flows:**  

![](/images/2019-08-27-00-14-39.png)   

# Conclusion  
So, these were the brief discussions about some fundamental concepts in computer networking. More on Computer Networking to follow soon!  
