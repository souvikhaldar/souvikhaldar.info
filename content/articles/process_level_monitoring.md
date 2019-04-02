---
title: "Process/Service level monitoring and alerting in Prometheus"
date: 2019-04-03T00:06:21+05:30
draft: true
---
# Introduction
Most of Linux systems these days use [systemd](https://www.freedesktop.org/wiki/Software/systemd/) for service management, is responsible for starting rest of the system and is assigned the PID 1. We can easily create a service out of command by writing a systemd unit file for it. This is typically the practice for making sure a process keeps running as a system process and avails a vaild PID. This is multiple benefits as well, you can read/manipulate the logs by using `journalctl`, start/stop/restart a service, send required signals to it, etc.

# Need
As we looked at the benefits above, it becomes quite necessary to monitor `systemd` services hence. You should be aware of the current state of the services. In my case and many others, I run the web server as a `systemd` service and hence it becomes utterly important that I know if it as gone down or not, when it has gone down, for how long, etc.
So apart from monitoring we will also look at how we can set up alerts so that we can receive an email whenever a particular process/service goes down.


