---
title: "Perkeep"
date: 2020-05-07T12:38:56+05:30
draft: false
---
# Perkeep
[Perkeep](https://perkeep.org/) is an amazing Open Source Software that is used to store images from various sources (like Google Photos) and store it permanantly in a neat searchable fashion with intuitive UI. Since this is FOSS you can free to use it anyway you want, but the question is how do you want to set it up. It follows typical client-server architecture (where the client can be android as well) and run the server anywhere you want, for more information on setting up the server read [this article](https://perkeep.org/doc/server-config). 
How I prefer setting up is:  
1) I have an old laptop with 1 TB HDD, hence it can run used to run the perkeep server.  
2) I've installed the perkeep android app from playstore, so that I can continuously upload images from mobile.  

Now let me explain in detail how did I follow the above two steps.  

# Configuration

1) Read [this](https://perkeep.org/download#getting-started) for installing the perkeepd on laptop.  
2) Now you can run the server by executing `perkeepd` on the terminal (after putting `perkeepd` on $PATH or changing directory to location where the executable perkeepd exists).
3) Now install the perkeep app on android from the playstore and in `settings` put <ip-of-laptop>:3179 in the Perkeep server option.
4) Now you can click on **Upload All** from options top right, but you might face Authentication issue like [this](https://github.com/perkeep/perkeep/issues/1308#issuecomment-624798442).  
5) So, let's configure the perkeepd server on laptop now:  
