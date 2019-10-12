---
title: "Pycon India 2019, Chennai, Day 1"
date: 2019-10-12T09:18:55+05:30
draft: false
---
PyCon India, the Python conference, is organized once every year, in some city of India and this year it was organized in the city of Chennai.   
![](/images/pycon.jpg)  
It was the 11th iteration of annual gathering of Pythonistas. It's a two-day conference with talks ranging from data science, machine learning to cyber security, graphQL,etc, i.e all the genres where python is being used extensively. The venue for PyCon in Chennai is the convention centre of Chennai Trade Centre. Parallel talks on different topics go on simultaneously in different halls, more details on the speaker line up can be found [here](https://in.pycon.org/2019/).  
The conference this year started off by the keynote speech of [Jake VanderPlas](https://twitter.com/jakevdp)  
## The power of python in data science.
*Jake Vanderplas* divided the usage of Python over the time period in the following stages:-  
i) 1990s: The Scripting era - alternative to bash   
ii) 2000s: The SciPy era - alternative to matlab  
iii) 2010s: The PyData Era - alternative to R   

He emphasized the following steps/tools for learning data science in python:-  
* Conda (prefer miniconda)  
**Difference between pip and conda**- pip installs any package in any environment but conda installs any package in conda environment. This can install all the required tools and packages. Some of these are:-  
* Dask- generate graphs for several backends.  
* SciPy- functions for scientic computations 
* Numba- Compiles python code to LLVM code. (just add required decorator in the same code)  
* Cython- Combination of C and python. Mostly for speeding up python code.  

P.S- I couldn't cover all the talks, but managed to take note from a few.  
 
## Rest in REST; Rise of graphQL   
*Abhishek Mishra* explains the drawbacks of traditional REST based architecture of APIs and why GraphQL makes things easier and more frontend friendly i.e BFF **B**ackend **F**or **F**rontend.  

Use *Graphene* library of python for implementing GraphQL.  
Downsides of REST-  
a) Over/Under fetching  
b) Weak typing  
c) third party tools for documentation  
d) Multiple endpoints  


Pros of graphQL-  
a) Single request, single endpoint  
b) specification not implementation  

what is graphQL-  
a) Query Language  
b) Strongly typed- schema driven  
c) DSL on top of backend data fetch logic  

Graphene-  
a) Code first  
b) python code to describe data  

## Smart lock? Nah! Pwning a smart lock using Python  
*Aniruddh*   
Explained a vulnerability in the smart locks which allowed unauthorized people to own a lock and henceforth unlock it! They used BurpSuite to read and understand the communication the locks were making to the server, where they found the vulnerability.  
Then they used *requests* library to write a script, which simulated the behavior of communication between the lock and server, to impersonate as the original user then eventually crack the lock!  
This suggests the lack of security research in IoT field and why this is becoming important day by day!  

##  Extract table from PDF  
Camelot is the open source library created by *Vinayak Mehta*, which can efficiently extract tablular data from the PDFs.

`pip install camelot-py[cv]` (dependency - `tk` and `ghostscript`)   

Finally, the day ended with the talk on Empowerment of women in the field of technology by the keynote speaker Devi ASL.  








