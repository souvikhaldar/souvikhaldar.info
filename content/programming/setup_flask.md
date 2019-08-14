---
title: "Setup Flask on Mac OSX for development"
date: 2019-08-13T17:55:50+05:30
draft: true
---

* > The version of Python that ships with OS X is great for learning but it’s not good for development. The version shipped with OS X may be out of date from the official current Python release, which is considered the stable production version.

    Install [Homebrew](https://brew.sh/#install) first. 

* Install required python version. If you want to use python2 use this:-  
`brew install python@2`  
Because python@2 is a “keg”, we need to update our PATH again, to point at our new installation:

    `export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"`   
* Install `virtualenv`  
Python3 has `virtualenv` installed by default.  
If you needed to install virtualenv because you are using Python 2, use the following command instead:

    `python2 -m virtualenv venv`  

* Now `cd` into your required directory and activate the virtual environment.  
    `. venv/bin/activate`   

*  Install Flask  
    Within the activated environment, use the following command to install Flask:  
    `pip install flask`  
 






