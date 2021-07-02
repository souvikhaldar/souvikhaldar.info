---
title: "Stack_smashing"
date: 2020-05-05T12:50:24+05:30
draft: true
---
# Stack Smashing: Paper by Aleph One 
This is going to be by best effort to understand Buffer Overflow mechanism from the above mentioned paper and produce the gist of my understanding in the form of this article in clearly defined bullet points.  
*  The process in which one can write past the length of the a declared array is called smashing the stack. This can cause the return address of the called routine to point to some unwanted address.  
*  A buffer or array is a contiguous allocation of a memory of certain type.  
*  Variables in C are of two types, static or dynamic. Static variables are created in the Data Segment during the load time and dynamic variables are created in the Stack during the run time. To understand how a process runs in the OS and how is it allocated memory follow [this video](https://youtu.be/ulhHqSwFcLA).  
*  Stack is actually a Abstract Data Type which has the property that the last inserted element would be the first one to be ejected. 
*  Stack ADT is selected for storing addresses because in the control flow of modern languages, when a method is called it has to return to the address from where it was called. Hence when a method is called, a new frame is *pushed* into the stack and deleted (*popped*) when it's done executing, returing to the address from where it was called.  



