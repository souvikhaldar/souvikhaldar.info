---
title: "RESTful HTTP API development in Go"
date: 2019-08-04T15:58:48+05:30
draft: true
---

# What is REST
REST, acronym for Representational State Transfer, is the architectural approach to building web services. Let's discuss a few characteristics of REST:  
* REST is independent of any underlying protocol. i.e REST API can be build over any protocol like REST HTTP API which means RESTful API built over HTTP protocol.  
* REST is independent of any specific implementation detail. i.e a REST API can be built on any language,tool,environment,etc. Almost every language allows one to write a REST API. The participating Client and Server can be built,modified and scaled separately, as long as they communicate in a consistent manner.  

# Design principles of RESTful HTTP APIs  
* Statelessness: The participating client and server are not required to know the state of each other. Essentially every request/response is independent and does not have any knowledge of the previous request/response.  
* REST API endpoints are designed around *resources* which can be an object,service,data,etc. For example, an endpoint `/addCustomer` is invalid whereas `/customer` with POST verb is better suited (we'll discuss about HTTP verbs later)  
* A resource has an identifier in the URI which helps to uniquely identify the resource. Like `/customer/24` signifies the customer with a unique identifier `24`.  
* The clients communicate with the service by exchanging representations of the resource. There are many exchange formats like XML,JSON,etc but these days JSON is heavily used (Javascript Object Notation).  
* There are four basic HTTP verbs to communicate with the resources.  
    1) `POST` : Create a new resource (non-idempotent in nature)  
    2) `PUT`: Update a resource or collection of resources (idempotent in nature)  
    3) `GET`: Retrieve a resource or collection of resources.  
    4) `DELETE`: Delete a resource or collection of resources.  

# Let's start building  
In this guide we will create a simple API which can perform CRUD operations i.e **C**reate  **R**ead **U**pdate **D**elete.  
C --> create a new customer instance (POST)  
R --> fetch a customer's details (GET)  
U --> update a customer's detail (PUT)  
D --> delete a customer's instance (DELETE)  
The standard library of Go is really very powerful, you can write a full blown server by using just the [standard library](https://golang.org/pkg/)!  
I’m assuming your system is setup for writing Go programs, if not you can [follow this link](https://golang.org/doc/install) and get it done.  
1. Create a directory in the `$GOPATH/src/<vcs-name>/<username>/golang-server` and name it anything you want. I’m naming in `golang-server`. 
The above path is standard golang practice, but after the onset of `go modules` you can create the directory anywhere you want.  
For me the path looks like:-  

![](/images/2019-08-04-21-11-41.png)   

2.  Build these three directories structure inside `golang-server`:  
`mkdir pkg cmd scripts`  
(This directory structure is not compulsory but a good practice.)  
To learn the reason for this directory structure you can explore this [repository](https://github.com/golang-standards/project-layout).  
TL;DR /cmd stores to binary executables, /pkg stores the packages, /scripts stores the required scripts for various use cases.  
3. Create a file called `main.go` (you can name it whatever). This is where the `main` function resides, inside `/cmd/golang-server/`  
4. Let's first write the handler for adding a customer's details.  








