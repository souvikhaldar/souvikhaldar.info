---
title: "Pycon_day2"
date: 2019-10-13T10:58:44+05:30
draft: true
---
# GraphQL with Django
*Anitha*  
Data query and manipulation language for the APIs.  
SQL for database ~  GraphQL for APIs.  
  
Supports reading, writing and subscribing to data.  
Returns only what is required.  

Building blocks-  
1) Type- schema
2) Query- Fetch 
3) Mutation- Modify  
4) Resolver functions  

django-graphene  

Writing modular resolver functions can ensure that response is faster and avoid Single Point of failure, because now the stress can be shared among lot of functions.  

# Visual studio code + python= Awesomeness 
*Sagar*  

# Numba
Covert python code to fast machine code. 
from numba import njit 
Just import numba and add the required decorator. ( @njit decorator)  
We can also use jitclass of numba for initializing the members of the class, which can otherwise be initilized in the __init__.   

# Generators 
Generators are basically lazy iterators. 
`yeild` can be used for creating a generator. 
It automatically converts the range argument to a `iter` object.  
g = (i**2 for i in range 10) 
g is a generator. 


