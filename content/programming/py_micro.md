---
title: "Let's talk about Microservice Architecture"
date: 2019-12-04T12:54:07+05:30
draft: false
---
# What is microservices architecture? 
1. Follows Unix philosophy *"Do one thing, do it well"*. 
2. It is a variant of Service Oriented Architecture (or SOA).

*Service-Oriented Architecture (SOA) is an architectural approach in which applications make use of services available in the network. In this architecture, services are provided to form applications, through a communication call over the internet.*  

So we can think of SOA as a generic version of Client-Server architecture where server can serve to request from any client and not not specific client, as in the case of a typical client-server architecture.  
3. The purpose of microservice architecture is to decouple the system and make it more modularized. The different components of the system are made loosely coupled. The idea is to achieve "Separation of Concern".  
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

## Typical structure of a microservice 

A microservice consists of three major components:  

 
| Communication   | --> | Processing | --> | Storage |
   

 i) Communication is mostly implemented in the form HTTP API or gRPC endpoint. It is used to recieving the request and responding with the response.  
 ii) Processing is the central logic of the microservice the requests is processed and response is generated.  
 iii) Storage is optional but if a microservice requires persistent storage then it need to have a separate database.   

 Finally signing off by saying, in next post I'm going to implement a microservice in Golang, and why Golang? [Read here](https://rubygarage.org/blog/top-languages-for-microservices). Till then, happy coding :)

