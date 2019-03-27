---
title: "Monitoring a linux/windows server using Prometheus"
date: 2019-03-25T13:09:45+05:30
draft: false
---

Monitoring of a system is key to it's smooth functioning. Going to the battle field (production) with having proper monitoring setup done is like making your platform vulnarable, hence to obtain full control it becomes a must; as the popular say goes *"Failing to plan, is planning to fail"*. 
In this article I'm going to show how you can monitor a system using Prometheus, node_exporter and the Grafana UI.

## Installation

We will install `prometheus`, which will pull metrics from the target server, `node_exporter` which will make the system's metrics available at an HTTP port, for `prometheus` to pull; and `Grafana` which is the UI for an amazing visualization.

### 1. Prometheus
Installation procedure is pretty simple, I'm going to show how to install on two platforms, Arch linux and Ubuntu.
For others you can definitely follow the [official docs](https://prometheus.io/download/)

#### Arch Linux
Arch has package for prometheus, which is great because then you don't need to explicitely write unit file for the service.

1. `sudo pacman -S prometheus` 
2. `sudo systemctl enable prometheus` (to create systemlink to the unit file in the systemd directory to that the systemd can always start it at boot) 
3. `sudo systemctl start prometheus` to start the service right away.

Now if you wish to check whether it is running properly or not you can run `systemctl status prometheus`.

#### Ubuntu

1. Download `wget https://github.com/prometheus/prometheus/releases/download/v2.8.0/prometheus-2.8.0.linux-amd64.tar.gz`
2. `tar -xzf prometheus-2.8.0.linux-amd64.tar.gz`
3. Move the `prometheus` binary executable to PATH `mv prometheus-2.8.0.linux-amd64/prometheus /usr/local/bin/`
4. Configure the prometheus config file (`prometheus-2.8.0.linux-amd64/prometheus.yml`) with simple configurations:- 

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
    
(Alternaltively you can use apt to install prometheus as well)

Now you can visit `<ip-address>:9090` on browser to see promethues running. Kudos you've successfully set up prometheus on your monitoring server. 
(make sure port 9090 is open for http)


### 2. node_exporter
The Prometheus Node Exporter exposes a wide variety of hardware- and kernel-related metrics, which prometheus can scrape metrics from. Typically `node_exporter` is installed on the target machine which you want to monitor and `prometheus` is installed on a vertically scaled (it demands heavy resource, generally) server which is primarily used as the master to monitor the target servers.

Here I will show you how you can install `node_exporter` on Debian and Windows server. Prometheus will keep pulling metrics from them and hence monitor.

#### Debian

The official [docs](https://prometheus.io/download/) will show to use the tarball (ref. - follow the above guide for installing prometheus on ubunut) but for convenience we will use the [official debian package](https://packages.debian.org/stretch/prometheus-node-exporter).  

1) `sudo apt-get install prometheus-node-exporter`
   
2) This by default enables and starts the node exporter service but you can cross check by `systemctl status node_exporter.service `

#### Windows

Unfortunately `node_exporter` is not well-supported on windows and hence we will use an [alternative](https://github.com/martinlindhe/wmi_exporter)

1) Visit https://github.com/martinlindhe/wmi_exporter/releases
   
2) I would recommend to download and run the `.msi` as can setup most of the things for you. 
  By default the service will start running on port 9182 so make sure to open that port to prometheus server.

Now, make this newly created node_exporter a target for prometheus to pull.
Add the following lines to promethues configuration file i.e `prometheus.yml`:-

For the above mentioned `debian` target server:-
```
- job_name: 'node_exporter'
    static_configs:
      - targets: ['<target-server-ip>:9100']
```

Similar for the above mentioned `windows` target server but change the port address to `9182`.
These ports are the default values and can be changed according to need by making necessary changes to configuration file of the exporters.

For the new target to get ready to be configured we need to restart the `prometheus` service so that it read the updated configuration i.e `prometheus.yml`. 
Run `sudo systemctl restart prometheus.service`.
The downside to this `restart` is that this will cause a downtime during the restart process. To get around this downtime follow this neat *trick*.
The idea is to send a hang-up single to the `prometheus` service which will make it reload the configuration.
For that first we need to know the PID (process ID) of the process. 
Run `ps aux | grep prome*`
```
[souvik@quiche ~]$ ps aux | grep prome*
prometh+ 29115  0.1  1.5 1142212 126020 ?      Ssl  Mar26   1:32 /usr/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/data
souvik   33410  0.0  0.4 891840 39956 pts/1    S+   03:12   0:00 journalctl -u prometheus -f
souvik   33445  0.0  0.0   6268  2316 pts/2    S+   03:18   0:00 grep prome*
[souvik@quiche ~]$ 
```
So now we know that the PID of the prometheus service is `29915`.

Now we need the hang up signal to it.
Run `sudo kill -s HUP 29115`

This will make prometheus reload the configuration as evident in the below logs:-
```
Mar 27 03:20:36 quiche prometheus[29115]: level=info ts=2019-03-27T10:20:36.618684382Z caller=main.go:724 msg="Loading configuration file" filename=/etc/prometheus/prometheus.yml
Mar 27 03:20:36 quiche prometheus[29115]: level=info ts=2019-03-27T10:20:36.619961054Z caller=main.go:751 msg="Completed loading of configuration file" filename=/etc/prometheus/prometheus.yml
```

*kudos*

**Now visit the `Status --> Targets` on the prometheus's address in the browser and your target server will appear there.** 
Now you can query for basic matrics and see it'c corresponding graph on the dashboard. But Grafana makes it cooler. Let's grab it now.

### 3. Grafana

#### Debian
Link to [docs](http://docs.grafana.org/installation/debian/)

1) `wget https://dl.grafana.com/oss/release/grafana_6.0.2_amd64.deb`
2) `sudo dpkg -i grafana_6.0.2_amd64.deb`
3) `sudo systemctl start grafana-server.service `
4) `sudo systemctl enable grafana-server.service`


#### Arch Linux

1) `sudo pacman -S  grafana`
2) `sudo systemctl enable grafana`
3) `sudo systemctl start grafana`

Now open port 3000 because by default Grafana listens on port 3000.
Now hit <server-ip>:3000 and you can see Grafana running. The default username and password is `admin` and `admin` respectively.
Congratulations, your pretty dashboard is now setup correctly!


Now we need to configure Grafana to set `prometheus` as a data-source. 

## Configure Grafana

1) Visit `<montoring-server-ip>:3000`.  
   
2) Click on `Add data source`
   
   ![](/images/2019-03-27-16-32-40.png) 

3) Select `prometheus`
4) Let the defaults be. Check if the address the alright.
5) Import a pre-built dashboad but clicking on `+` icon.
6) Import `1860` and `405` as Dashboard ID.
  
#### Voila you have the pretty dashboard ready!

*visit `<monitor-server-ip>:3000`*

![](/images/2019-03-27-16-58-33.png)
*405*

![](/images/2019-03-27-17-01-03.png)

*1860*

![](/images/2019-03-27-17-05-27.png)
*Some more*

![](/images/2019-03-27-17-13-30.png)
*windows node*

So that's a brief walk-through of the setup of monitoring system for a linux and windows server. Now you can customize further and setup alerts for different scenarios using `Alert Manager`. You can go through this cool video [tutorial](https://youtu.be/4WWW2ZLEg74) if you are more of a video person.
Thanks and I hope I was able to at least get you started with the popular and amazing monitoring tool **Prometheus**.

