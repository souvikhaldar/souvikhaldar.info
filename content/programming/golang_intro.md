---
title: "A brief introduction to Go programming language"
date: 2019-08-03T23:52:50+05:30
draft: false
---

## What is Go?
The Go programming language (A.K.A Golang) is an open-source language built by Google. Some of the biggest names in the world of Computer Science are associated with Go, namely Rob Pike, Ken Thompson and Robert Griesemer. There are several characteristics of Go that makes it a perfect fit for building simple, reliable and efficient software, let's discuss them now.  

## Characteristics of Go
* Open-source- The very nature of the open-source product assures that it is a language built by the community for the community.

* Statically typed- When you’re building production-grade software, type safety avoids a LOT of bugs that arise simply due to the assignment of unsuitable type of value to a variable. Static typing allows early detection of trivial bugs.
Such errors in dynamically typed languages like python are thrown only at runtime, which is not desirable.  
`a = 'foo'`  
`b = True`  
`c = a / b`  

* Generates Binary executable - Go is a compiled language that can generate binary executable with all the dependencies baked into it. This essentially means, for running the binary one does not need any runtime support. Plus the binary generated is really small in size, added bonanza :) 
The best result that comes out of it is, one can containerize a full blown software in ~5 MB! That’s a really small number! This process of building a container is called multi-stage build. 

* Cross-platform- This is one of the most amazing feature of golang, which makes it the language of choice for the DevOps people too. Go can generate binary executable for different target platform! What is means is, you can write Go code on Darwin (Mac) and generate binary which can run on linux, so on and so forth, with no requirement for any other support! 
Also, it isn’t like Java which can also run on different platforms, but the catch is, it requires the Java Virtual machine to be installed on the target platform, which is hugely memory hogging!

* Concurrency- This is the feature that makes puts Go in the lead position in the field of Backend Engineering. Concurrent programming is a nightmare for most of the developers. But the way Go deals with it is a breeze! Concurrency is first class citizen in Go. You can run a process in a new goroutine (light-weight thread) just by prefixing the function invocation call with `go`. There’s a lot to talk about it but you [read my article](http://souvikhaldar.info/programming/go/) on this topic which elaborates it further.


## Why learn Go?
If you still not convinced to learn Go after reading the above points, let me show you the practical benefits of learning it, as of July,2019.  

* According to stackoverflow 2019 survey results, Go ranks at 3rd spot in the rankings for Most Wanted Languages.  
    ![](/images/2019-08-04-00-30-33.png)

* Go finds itself at 3rd rank in the list for highest paying job’s language globally.   
    ![](/images/2019-08-04-00-03-48.png)  

* The number of available jobs for golang professionals are increasing day by day as more companies are starting to adopt Go in the toolchain and also migrating legacy codebases to Go, for the good reasons.  

*  It has a unique methodology for software development. It’s design has best of object oriented principles mixed with modern interface based programming. It promotes [composition over inheritance](https://odetocode.com/blogs/scott/archive/2019/01/03/composition-over-inheritance-in-go.aspx).   

## Conclusion   
I believe I was able to provide atleast the very basic points which puts Go in a very sweet spot and why one should learn it now. Currently Go is being heavily used is almost every domain, ranging from server development to DevOps, from Cyber security to Blockchain, the possibilities are endless! But Go is getting immensely popular in the the server side development, which also happens to be my field of expertise and job role, hence I'll be soon writing an article on "RESTful API developmemt in Go". Till then, *Happy Coding* :)
