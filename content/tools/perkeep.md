---
title: "Perkeep: Your own Google Photos, for life"
date: 2020-05-07T12:38:56+05:30
draft: false
---
# Perkeep
[Perkeep](https://perkeep.org/) is an amazing Open Source Software that is used to store images from various sources (like Google Photos) and store it permanantly in a neat searchable fashion with intuitive UI. Since this is FOSS you can free to use it anyway you want, but the question is how do you want to set it up. Also, these days, the mobile phones have made it very complicated to backup photos to laptops so that they can force you to use more their cloud services, like Android will ask for more GDrive and apple for iCloud, which costs a lot in the long run and kinda makes you dependent on them. Recently when I was trying to backup photos from my OnePlus 7 Pro to Macbook, I had to literally run an FTP server to send data or `rsync` files from `termux` to my laptop! **Perkeep** makes the entire process fully automated,fast as well as secure because control of the entire cloud storage is upto you. Plus, there are many search features, intuitive GUI,etc which are cherry on top!  
It follows typical client-server architecture (where the client can be android as well) and run the server anywhere you want, for more information on setting up the server read [this article](https://perkeep.org/doc/server-config). 
How I prefer setting up is:  
1.  I have an old laptop with 1 TB HDD, hence it can run used to run the perkeep server.  
2.  I've installed the perkeep android app from playstore, so that I can continuously upload images from mobile.  

Now let me explain in detail how did I follow the above two steps.  

# Configuration

1.  Read [this](https://perkeep.org/download#getting-started) for installing the perkeepd on laptop.   
2.  Now you can run the server by executing `perkeepd` on the terminal (after putting `perkeepd` on $PATH or changing directory to location where the executable perkeepd exists).  
3.  Now install the perkeep app on android from the playstore and in `settings` put <ip-of-laptop>:3179 in the Perkeep server option, Username (let's say) foo and Password as bar.  
4.  Now you can click on **Upload All** from options top right, but you might face Authentication issue like [this](https://github.com/perkeep/perkeep/issues/1308#issuecomment-624798442).    
	So, let's configure the perkeepd server on laptop now:    
	1.  Since we picked username as foo and password as bar, change the value of "auth" as following in `~/.config/perkeep/server-config.json` (and leave rest as it is in your case):   
		```
		{
 		   "auth": "userpass:foo:bar",
   		   "listen": ":3179",
    		   "camliNetIP": "",
   		   "identity": "KJBSDBGSJDG",
    		   "identitySecretRing": "/home/user/.config/perkeep/identity-secring.gpg",
    		   "blobPath": "/home/user/var/perkeep/blobs",
    		   "packRelated": true,
    	           "levelDB": "/home/user/var/perkeep/index.leveldb"
		}
		```
	2.  Create a systemd unit file for that the `perkeepd` daemon can keep running as systemd process. Create a file named `perkeep.service` at `/etc/systemd/system/` and add the following content into the file: (Put your values accordingly)      
		```
		[Unit]
		Description= Perkeepd server
		[Service]
		WorkingDirectory= /home/user/path/go/bin/
		ExecStart= /path/to/GOPATH/bin/go/bin/perkeepd -configfile=/home/user/.config/perkeep/server-config.json
		Restart= always
		[Install]
		WantedBy= multi-user.target
		```
	3.  Now start this service by running `sudo systemctl start perkeep.service`, if it runs fine, web UI would be visible at `localhost:3179`, if not try to debug it by checks `systemctl status perkeep.service`. If everything is fine, enable this service so that during reboot this service can start automatically. For enabling run `sudo systemctl enable perkeep.service`.    
	
6.  Now click Upload all option on your android device and images should start popping up at `localhost:3178/ui`. Your own Google Photos with unlimited storage, almost permanent, easily searchable with intuitive UI right in front of you:   
	![](/images/2020-05-12-11-24-40.png)	 

	 Locate on maps (one of many features):  
	 ![](/images/2020-05-07-16-36-26.png)  



# Conclusion		
There are various ways to go about the setup which are much much better, like storing in s3, reverse proxy to machine, setup HTTPS and what not! This guide was simply to get you started and pique interest. Now you can keep tinkering till you find the sweet spot :)  

