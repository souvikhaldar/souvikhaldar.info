---
title: "Brief Walkthrough of concurrency model in Go"
date: 2019-03-24T12:13:31+05:30
draft: false
---

Introduction
Around the year 2005, CPU manufacturers reached the limit of increasing the speed of the processors physically, which may also be thought of as reaching the saturation point of Moore’s Law. Hence they started adding more cores to the CPU viz. Dual-Core processor, Quad Core processor, etc., for enhancing the performance. Unfortunately, older languages are not very efficient at exploiting the benefits of the modern hardware comprising of multi-core CPUs. Here, Go fills the need by having concurrency support built in, which can very efficiently make use of the multiple cores for better performance. This article is a high level and brief walkthrough of the concurrency model of Go.

Concurrency in Go
Goroutines are lightweight threads that are managed by the Go runtime. go f(x,y) starts are new goroutine running f(x,y).



Playground- https://play.golang.org/p/f0sLl05L4f6

The code above will print “world” and “hello” five times after an interval of 100 milliseconds in a random manner as function `say` would be printing the argument string in different goroutines. The lightweightedness of goroutines can be established with the fact that a typical goroutine takes 4 KB of memory on the Stack whereas a typical thread in Java takes about 1024 KB! Channels are the medium through which data is shared between goroutines.

c <- v // the data v is sent to channel 
c v := <- c // the data from channel c is stored in variable v
By default, sending to a channel and receiving from a channel is blocked until they are ready, this makes the goroutines synchronized without using explicit locks or conditions. Channels can be buffered as well. If you provide a second argument (buffer length) to the make command for a channel it becomes buffered, otherwise unbuffered.

UnbufCh := make(chan int) // creating an unbuffered channel 
bufCh := make(chan int,5) // creating a buffered channel of buffer length 5
Sending to a buffered channel is blocked when it is full, similarly reading from a buffered channel is blocked until it is empty. Overfilling a buffered channel causes error- fatal error: all goroutines are asleep — deadlock!



Playground — https://play.golang.org/p/zGJok8HZcMp

We can loop over a channel using range keyword. Hence, closing the channel from the sender side is advised so that loop the receiver can break the loop when the sender has nothing more to send.


Playground — https://play.golang.org/p/HO0TrtCgaGl

The sender to a channel can close the channel indicating that it has nothing more to send. To check if a channel is closed we can do:

Val, ok := <- c // if channel c is closed ok will be returned false

Note: Only sender should close a channel and never the receiver because sending on a closed channel can cause panic. Also, closing is not mandatory but useful when the receiver is looping over the received data.

select statement is like switch, but for channels. A select statement makes a goroutine wait on multiple channels. It blocks the execution unless one of its case becomes true and then executes that. If multiple cases are ready then select chooses one at random. The default case runs when no other case is true.

An empty select statement blocks the flow of execution further viz select{} Example:


Here the quit case in the select statement becomes true only after 0 is sent to the quit channel, causing the program to return. Playground — https://play.golang.org/p/pYTwi-SNiIG

For sharing data among goroutines, channels serve the purpose well. But often, we just need to make access for certain variable (also called critical section) mutually exclusive for the goroutines to avoid an unwanted scenario called Race Condition.

A Race Condition is a condition in which more than one process (threads, here goroutines) tries to access shared data (critical section) causing inconsistency.

Conventionally, the data structure used for providing mutual exclusion is called mutex. Go’s standard library provides this feature with the help of sync.Mutex and its two methods Lock and Unlock. We make sure that when a goroutine enters a critical section we lock entry to this for other goroutines using Lock and at the moment the entered goroutine leaves the critical section, we Unlock it so the next goroutine can now enter it and plausible conflicts are avoided.

sync.Mutex.Lock() 
// <Critical Section>
sync.Mutex.Unlock()



In the playground — https://play.golang.org/p/REkXEEoNdap

Conclusion
Hence, we see that the concurrency support in Go is simple and convenient yet powerful. This model of concurrency as the first-class citizen in Go has gained incredible popularity and made it the language of choice for most modern progressive startups as well as big giants like Netflix, Uber, Slack, Medium, Google, etc. Hope this simple walkthrough helped you get started with the concurrency model in Go; for further understanding, you can watch this amazing video. Happy coding!

This article was originally published in the January edition of Hakin9 magazine. Vol. 13. №10.

Buy- https://hakin9.org/product/introduction-to-ethical-hacking-become-the-owner-of-network/