---
title: "GDG Kotin meetup Kolkata"
date: 2019-04-27T10:17:53+05:30
draft: true
---
 Dr. [Venkat Subramanium](https://twitter.com/venkat_s) was the esteemed speaker at GDG Kotlin meetup held at IEM Kolkata on 27th of April,2019. He is the professor at University of Houston and founder of [Agile Developer Inc](https://www.agiledeveloper.com/). It was a great learning experience, he was talking about Domain Specific Languages and how it increases the fluency. He also introduced Functional Programming paradigm in Kotlin and it was spectacular! Some brief notes from his talk:-

# Characteristics of good DSL
* Has a context
* has fluency

# Specialities of Kotlin
* Kotlin is fluent
* drop () and . by prefixing a keyword "infix"
* no () for passing last lambda
 Adding methods to existing classes :-
	fun String.shout() = toUpperCase()
 *Can* modify the behavior existing methods as well which I felt was a bit dangerous feature to have. 
* "2 days ago" can be written as:-
 1)println(2 days ago) can be written by the help of extension function on Int 2
 2)Then removing the . and () by using the "infix" operator.

* Parallel vs Asynchronous
* non-blocking
	If a function call takes time, you do other stuffs.	
	YOU DONT WAIT.
* coroutines are asynchronous
	You can stop work at some point and then resume again later.
* concurrency --> Multiple thread starts execution at the same time but at any given moment only one thread runs.
* The coroutines by default runs on the same thread, unless you specify otherwise. 
	yeild() is used for execution delegation.
	`launch` keyword is used for making the process it's been prefixed with, a non-blocking one.
* How coroutines work?


* lambda is stateless.
* closure is the lambda with state.
* If the context is same it is concurrent and if the context is different then it is parallel.
* launch doesn't return but async with await returns.
* 
