---
title: "Linux tips and tricks"
date: 2020-02-19T15:34:23+05:30
draft: false
---

# Why?  
The terminal of UNIX based operating systems is insanely powerful, hence owning this power takes a lifetime. While learning it there are few tips and tricks that you can keep handy which will make you super productive. This document would be forever in *Work in Progress* mode and as I keep coming across any tips, I'll be documenting them here.

# tips
*  Sometimes we need super-user (`sudo`) privilege to run a command, but we realize it only after executing it. Hence when we try to run the command again we either rewrite the entire command or use the up arrow key to get it again then edit it. But there is a simple way to do it. Use `sudo !!` to run the previously executed command with `sudo` privilege.  
*  How to list the last three newly created files in a directory?  
`ls -ltr | tail -3`  
*  How to send last three newly created files in a directory to a server?  
``scp `ls -ltr | tail -3` username@<ip>:<location>``    
*  `?` variable stores the exit status code of last executed unix or linux shell command. If the value of `?` is 0 then it means that the last command executed successfully, but it it's non-zero, that means there was some error.  
Eg.  
![](/images/2020-04-17-22-54-33.png)  
*  Compress a directory:  
    *  fast- `tar -cv /path/to/dir | gzip --fast newFileName.tar.gz` (fast compression)   
    *  best- `tar -cv /path/to/dir | gzip --best newFileName.tar.gz` (best compression)    
* `pigz` is a parallel implementation of `gzip` is much faster when compressing multiple number of files:  
    `tar -cv source-dir/ | pigz --best > target-file-name.tar.gz`
