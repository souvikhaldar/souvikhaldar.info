---
title: "Monitoring a system using Prometheus"
date: 2019-03-25T13:09:45+05:30
draft: false
---

Monitoring of a system is key to it's smooth functioning. Going to the battle field (production) with having proper monitoring setup done is like making your platform vulnarable, hence to obtain full control it becomes a must; as the popular say goes *"Failing to plan, is planning to fail"*. 
In this article I'm going to show how you can monitor a system using Prometheus, node_exporter and the Grafana UI.

## Installation
Installation procedure is pretty simple, I'm going to show how to install on two platforms, Arch linux and Ubuntu.
For others you can definitely follow the [official docs](https://prometheus.io/download/)

### Arch Linux
Arch has package for prometheus, which is great because then you don't need to explicitely write unit file for the service.

1. `sudo pacman -S prometheus` 
2. `sudo systemctl enable prometheus` (to create systemlink to the unit file in the systemd directory to that the systemd can always start it at boot) 
3. `sudo systemctl start prometheus` to start the service right away.

Now if you wish to check whether it is running properly or not you can run `systemctl status prometheus`.

### Ubuntu

1. Download `wget https://github.com/prometheus/prometheus/releases/download/v2.8.0/prometheus-2.8.0.linux-amd64.tar.gz`
2. `tar -xzf prometheus-2.8.0.linux-amd64.tar.gz`
3. Move the `prometheus` binary executable to PATH `mv prometheus-2.8.0.linux-amd64/prometheus /usr/local/bin/`
4. Configure the prometheus config file (`prometheus-2.8.0.linux-amd64/prometheus.yml`) with simple configurations 

```
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']
```
5. Now write a unit file for the prometheus service. For more info on systemd and unit files see [here](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files#where-are-systemd-unit-files-found).

`sudo nano /etc/systemd/system/prometheus.service`
Add the following contents :-
```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]

Type=simple
ExecStart=/usr/local/bin/prometheus --config.file /home/ubuntu/prometheus-2.8.0.linux-amd64/prometheus.yml
[Install]
WantedBy=multi-user.target
```
6. `sudo systemctl daemon-reload`
7. `sudo systemctl start prometheus`
8. `sudo systemctl enable prometheus`
9. Now if you wish to check whether it is not or not execute `systemctl status prometheus`

Now you can visit `<ip-address>:9090` on browser to see promethues running. Kudos you've successfully set up prometheus on your monitoring server. 
(make sure port 9090 is open for http)


