---
title: "Kolkata Clojure meetup: Web Development in Clojure"
date: 2019-12-08T20:36:12+05:30
draft: False
---
I talked about building a web service in Clojure. I built a URL-shortening service for the same. The presentation can be found [here](https://docs.google.com/presentation/d/1P9GChVagzfivjWVNd9wBMfg9g9hi-rox93F4IYT10Rk/edit?usp=sharing).  
Description of the project.
## Redirector: URL shortening service

This is a minimalistic URL shortening service which can shrink your ugly/large URL to a beautiful short URL.

### Installation

Clone the repository from [here](https://github.com/souvikhaldar/URL-shortener)
Then run `(-main)` which is located in `core.clj`.

### Usage

It should be running on `localhost:3000`.

	* Shrink a URL  
		Make request on browser-->  `localhost:3000/shrink/<Enter-your-url-here>`

	* Retrive the original URL  
		Make request on browset--> `localhost:3000/redirect/<Enter-the-shrunken-URL>`

### Demonstration 
Follow this [link](https://youtu.be/IFA7gmiVa8E) to see a video demonstration of this service.  

**P.S**: Anyone willing to learn web development in Clojure can definitely refer to this repo. 

