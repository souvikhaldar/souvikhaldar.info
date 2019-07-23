---
title: "Learning Haskell: Part 1"
date: 2019-04-28T20:18:44+05:30
draft: false
---
# What is functional programming?  
A functional program is set of rules that govern a specific output on providing an input. The basic operation in functional programming in composition of functions.
* function f(x) is represented as f x.
* Recursive defination:-
  plus(n,m) == plus n m = summation of n and m
  succ(m) == m + 1
  plus n succ m == succ plus n m

# What is a function  
In mathematics, a function f with domain S and codomain T can be represented as f: S -> T, where Range R of this function should be subset of codomain T. Similarly in Haskell we can define the function type, input type and output type, where **type** is a well defined set of certain permitted values.

# Haskell, a purely functional programming language  
Simply put, Haskell is a programming language for defining functions.
It is two parts:-
* Type of the input and the output
* Rules for computing output from input

Type defination: `sqr :: Int -> Int`
Computation rule: `sqr x = x * x`

Haskell is a case-sensitive language.
Basic types in Haskell are:-
* Int
* Float
* Char
* Bool (True or False)

Boolean expressions- `&& || not < > == \= <= >=`

Sample:
![](/images/2019-05-06-13-23-31.png)



