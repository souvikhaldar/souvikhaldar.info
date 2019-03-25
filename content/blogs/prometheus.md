---
title: "Monitoring a system using Prometheus"
date: 2019-03-25T13:09:45+05:30
draft: true
---

* Installed prometheus on arch system using `sudo pacman -S prometheus` --> `sudo systemctl enable prometheus` (to create systemlink to the unit file in the systemd directory to that the systemd can always start it at boot) --> `sudo systemctl start prometheus` to start the service right away.