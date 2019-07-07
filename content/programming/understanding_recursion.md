---
title: "Understanding Recursion"
date: 2019-06-23T18:22:25+05:30
draft: true
---
## What is Recusion  
Recursion is a methodology of problem solving, where to get the solution of a problem by breaking it down to sub-problems and keep breaking it till we reach a point where we can't break it any further (also known as base condition). Once base condition is reached, we handle it then start returning the solution of the sub-problem state that we are in, to the caller sub-problem state (i.e the parent). 
Hence, this way we can solve the overall problem, by solving the subproblems.  
This is implemented by writing a function that calls itself, and hence keep breaking the problem.  
## Applications of Recursion  
1. Dynamic Programming
2. Divide and Conquer
3. Backtracking 
4. Tree traversal

## Example of recursive function

Recursion is be better understood with an example.  
Suppose we want to calculate factorial of a number in recursive fashion. Here you go:-  
