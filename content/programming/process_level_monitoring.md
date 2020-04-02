---
title: "Process level monitoring and alerting in Prometheus"
date: 2019-04-03T00:06:21+05:30
draft: False
---
# Introduction
Most of the Linux systems these days use [systemd](https://www.freedesktop.org/wiki/Software/systemd/) for service management, is responsible for starting rest of the system and is assigned the PID 1. We can easily create a service out of command by writing a systemd unit file for it. This is typically the practice for making sure a process keeps running as a system process and avails a valid PID. This is multiple benefits as well, you can read/manipulate the logs by using `journalctl`, start/stop/restart a service, send required signals to it, etc.

# Need
As we looked at the benefits above, it becomes quite necessary to monitor `systemd` services hence. You should be aware of the current state of the services. In my case and many others, I run the web server as a `systemd` service and hence it becomes utterly important that I know if it as gone down or not, when it has gone down, for how long, etc.
So apart from monitoring we will also look at how we can set up alerts so that we can receive an email whenever a particular process/service goes down.

# Steps
1. First you need to set up `SMTP` configuration in Grafana in order to be able to send mails. You can read about it in [this article](https://www.souvikhaldar.info/articles/alerting/). 
2. Now you need to modify the [`node_exporter`](https://github.com/prometheus/node_exporter) to be able to export  the `systemd` metrics. For this you just need to pass a flag named `systemd` to the `node_exporter` command. Here I'll show you how I did it.
   * On the target machine open the `node_exporter` service's unit file. You can find by looking at the output of `systemctl status node_exporter.service`.
     
        ![](/images/2019-04-03-00-35-05.png)
     
   *  Modify the `ExecStart` and append `--collector.systemd`
     (I'm sure there are [better ways](https://askubuntu.com/questions/659267/how-do-i-override-or-configure-systemd-services) than hardcoding like this, but for now let's do it this way)

        ![](/images/2019-04-03-00-38-03.png)

   * Reload the changes `sudo systemctl daemon-reload`.
     
   * Restart the service `sudo systemctl restart node_exporter.service` to apply the latest changes to the unit file.

        Optionally we can append `$ARGS` environment variable to the `ExecStart` and put its value in the `~/.profile`.

        ![](/images/2019-04-03-23-15-40.png)

3. Now you need to make Prometheus able to scrape the metrics sent by the node_exporter and for doing that you need to modify the configuration of Prometheus (typically the prometheus.yml file). Add the following:  
   ```
   - job_name: 'node-exporter'
     scrape_interval: 5s
     static_configs:
       - targets: ['<ip-of-server-running-node-exporter>:9100']
   ```  

4. Create a new Dashboard in Grafana for monitoring the required service. Here, for example, let's monitor a service called `go-analyzer.service`. 
    * Select the `Add Query` option.
    * Write the query `node_systemd_unit_state{name="go-analyzer.service"}`
    * It will look like- ![](/images/2019-04-03-00-48-53.png)
  
    **Voila! Now you can monitor the state of `go-analyzer` process**

5. Now we'll try to setup alert on this process so that we can get notified if this service goes down.
   * Modify the above mentioned query to `node_systemd_unit_state{name="go-analyzer.service",state="active"}`
   * Go to `Alert` section and `Create Alert`
   * Set the condition like - ![](/images/2019-04-03-01-08-00.png)
   * You can send to a channel (like `Server Team` here) or an individual and customize what message is sent ![](/images/2019-04-03-00-58-30.png)
   * Now save the dashboard and you are all good to go!

# Conclusion
To test the Alert, try to stop the service by doing `sudo systemctl stop go-analyzer.service`. You should get an alert email soon. ![](/images/2019-04-03-01-18-04.png)

Now you rest assured that whenever a crucial monitored service (maybe database, server, MQ service,etc) goes down you will be informed quickly and hence take required action faster!




