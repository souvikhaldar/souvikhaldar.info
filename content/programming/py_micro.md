---
title: "What is Microservice Architecture? Implementation of Microservice in Golang using go-micro"
date: 2019-12-04T12:54:07+05:30
draft: false
---
# What is microservices architecture? 

* It is a variant of Service Oriented Architecture (or SOA).

    *Service-Oriented Architecture (SOA) is an architectural approach in which applications make use of services available in the network. In this architecture, services are provided to form applications, through a communication call over the internet.*  

    So we can think of SOA as a generic version of Client-Server architecture where server can serve to request from any client and not not specific client, as in the case of a typical client-server architecture.  
    
*  Follows Unix philosophy *"Do one thing, do it well"*.  

* The purpose of microservice architecture is to decouple the system and make it more modularized. The different components of the system are made loosely coupled. The idea is to achieve "Separation of Concern".  

**Now let's talk about advantages and disadvantages of microservices architecture.**  

# Advantages
1. Since the system is decomposed into several independent services, hence each component can be scaled and fixed separately. Horizontal scaling becomes much easier this way!  
2. Each component is language and design independent from one another. Hence the system can be made polyglot and we can choose language or tool which can serve the particular component's purpose the best way possible.  
For eg, Suppose I'm building a software which needs to be highly concurrent and it needs to implement some Machine Learning algorithms as well. In monolithic architecture since the entire codebase is generally written in one language, in this case let that language be Python, then we can achieve a very good implementation of Machine Learning algorithms but stuck with not a very good framework for writing highly concurrent web server.  
It would have been best if we can write the web server in the language that supports high concurrency (like golang) and machine learning part in python as it has very good libraries for the same. Luckily, microservices architecture let's you achieve this very thing, since machine learning part and web server part can be made into microservice which can communicate with each other over network call (generally) and are hence independent of each other.  
3. Smaller size of each service makes understanding the system much easier. In monolithic architecture where the entire logic of the system lies at once place, understanding a particular part becomes difficult.  
For eg, Suppose Facebook has monolithic architecture. If I want to understand how Facebook handles the process of user sign up, then I would have to browse through millions of lines of code just to understand how sign up works. But if Facebook would have had microservices architecture where user sign up were a different service altogether, then I can directly go to this service and understand the workflow. This concept becomes very important as the size of the software grows and new employees keep joining the organization.  
4. It allows continuous delivery because the system is now loosely coupled (each service independent of each other).  
For eg, Let's say my software has two parts, sign up and sign in. If my work on sign up is complete and sign in is not, I can separately deploy sign up alone and not wait for sign in to get completed!  
5. Cost optimization can be achieved by scaling only those parts which need to be scaled.  
For eg., suppose I'm building a music streaming service, currently getting a lot of user sign up and not a lot of them are actually listening to music. Then, I can scale the user sign up microservice only and not the streaming service, hence cost is lowered.   

# Disadvantages

1. Difficult to test: Since the system is now divided into multiple parts, now for testing the entire system, each part (microservice) needs to be tested separately.  
2. Multiplication of issues: Let's say the entire system had **n** issues, and now it had been divided into **m** microservices, so now we have **n*m** issues!  
3. Lowered security: Each microservice has it's own interface of communication, hence the number of communication interface gets increased, so is the surface area for attack!  
4. Increased number of dependencies.  
5. Maintenance becomes complex.  
6. Most of the communication between the microservices happens over the network, so latency is increased.  
7. Some messages might drop, leading to lesser reliability. (This is can fixed to a great extent by using Message Queues in between the services like Kafka, Rabbit MQ,etc)  

# Typical structure of a microservice 

A microservice consists of three major components:  

 
| Communication   | --> | Processing | --> | Storage |
   

 i) Communication is mostly implemented in the form HTTP API or gRPC endpoint. It is used for receiving the request and responding with the response.  
 ii) Processing is the central logic of the microservice the requests is processed and response is generated.  
 iii) Storage is optional but if a microservice requires persistent storage then it need to have a separate database.   
Now let's implement a simple microservice which takes two argument as parameter, adds them and returns the result. We will be doing this using the go-micro framework in golang.  

# Implementation in Golang

Firstly, why golang, for writing a microservice?  
1. Syntax is as simple as Python, yet the software produced is very reliable because of type safety, Garbage collection, no fancy tricks!  
2. It produces static binary for almost all possible platforms. You can code in Mac to create binary for linux, windows,etc. Plus the single binary executable allows creating containers as small as 5 MB which highly decreases the boot time.  
3. It has great support for building microservice. In fact, according to many, it has the best support. Frameworks such as go-micro, go-kit, gizmo, etc makes it a breeze!   
4. It is damn fast!   

We choose [go-micro](https://github.com/micro/go-micro) framework because abstracts a lot of complications of distributed systems and can almost be used directly out of the box! Do check out it's features.   

Please clone [this](https://github.com/souvikhaldar/golang-microservice-example) repository and refer to it in the following steps.  

## Pre-requites
1.  [Install Go](https://golang.org/doc/install)   
2. Install protoc-gen-micro `go get github.com/micro/protoc-gen-micro`   
2. Install Go's support for protocol buffers `go get -u github.com/golang/protobuf/protoc-gen-go`   
3. [Install protocol buffer compiler](https://github.com/protocolbuffers/protobuf)   

## Steps for writing own microservice
1. Write the API documentation in the protobuf as shown in `sum/sum.proto`  
2. Compile it using `protoc --proto_path=$GOPATH/src:. --micro_out=. --go_out=. sum.proto` . 
3. Implement the server by implementing the `Adder` interface as you can see in the generated go file (look the impl. in server.go) and the client (look at the impl. in client.go)  

##  How to run this example
Open two terminals, run server first in one terminal, then client in the other one. You're done! 


# Conclusion  
This was definitely a very simple service, but I hope it got you started. I talked about this at a meetup, you can find the [slides](https://docs.google.com/presentation/d/1XPZp-ZeiGtQiypJkqyYBfkdvvUWPtKPQQ2p5cm8vkGo/edit?usp=sharing) and [video demonstration](https://youtu.be/U7mKebOVoNY) here respectively. For any further, do reach out to me on [Twitter](https://twitter.com/s0uvikhaldar).  

