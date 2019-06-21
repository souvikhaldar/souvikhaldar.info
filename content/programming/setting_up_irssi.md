---
title: "Setting up IRC client: irssi on Mac"
date: 2019-05-16T18:59:51+05:30
draft: true
---

# What is IRC?
IRC is the abbreviation for *Internet Relay Chat*, which an application layer protocol used for communication between systems connected to the internet. It follows the [client-server architecture model](https://en.wikipedia.org/wiki/Client%E2%80%93server_model).

# What is an IRC client?
IRC clients are the computer programs that implements the IRC protocol to establish connection to the server, to which more clients are connected further and hence, can communicate with each other, in the client-server way.

There are several IRC clients available today, but I prefer to use terminal based clients, for example, bitchx, irssi, etc.
I love irssi and in this post I'm going to go step by step as to how **I** did the setup and configure irssi on mac, but linux distributions will follow similar configuration process.

* Installation 
`brew install irssi`
 
Now you can use it to connect desired server and then channels, manually. These following setups for that should suffice.
1. Connect to the server.   
Eg. `/connect chat.freenode.net` (if you want to connect to [Freenode](https://freenode.net/) server)

2. Identify yourself
`/msg nickserv identify <username> <password>`
Some channels doesn't require you to identify yourself, but mostly it does.
(PS- You need to register yourself first with freenode, follow [this link](https://freenode.net/kb/answer/registration))

3. You would not want to reveal your IP address, which is visible to anyone in the channel when you join it. There are many ways to hide it, but getting a cloak is the easiest. (though not very reliable)
To get a cloak, follow [this link](https://freenode.net/kb/answer/cloaks).

4. Join the required channel.
`/join <channel-name>`

Some basic commands that you might use regularly:-
    * `/msg <nickname>` to send private message.
    * `/exit` to leave irssi
    * `/me <message>` to write a message in second person.
    * `/whois <nickname>` to know about the person
    (other useful commands you can find [here](https://irssi.org/documentation/help/))

Now I'll show you how you can automate points 1,2 and 4 by [configuring SASL](https://freenode.net/kb/answer/irssi).

**Points 1 and 2**

1. `/network add -sasl_username <login> -sasl_password <password> -sasl_mechanism PLAIN freenode`
2. `/server add -auto -net freenode -ssl -ssl_verify chat.freenode.net 6697`
3. `/save`

**point 4**
1. `/channel add -auto <#channel-name> <network>`
eg. `/channel add -auto #dgplug freenode`
2. `/save`

Now, here you are to the world of IRC chatting, welcome to one of oldest platform of real-time communication!