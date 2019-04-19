---
title: "Alert Manager in Prometheus"
date: 2019-04-02T14:48:56+05:30
draft: false
---

# Introduction
Alerts are the most important feature of any monitoring system. You can although, always keep a tab open to monitor each and every event, but that's quite impractical. So, by setting alerts you can rest assured that in case of an emergency you will be notified appropriately by emails, slack, etc that something is not right, so you can take appropriate measures to analyse and finally fix it.

# Two simple steps

## 1. Setting up SMTP
Here I'll show you how you can setup SMTP so that emails can be sent out as alert. There are various other ways to notify as well.
Modify the `/etc/grafana.ini` (if you've installed Grafana using package manager, [otherwise](http://docs.grafana.org/installation/configuration/)) according to the content as follows:-
```
#################################### SMTP / Emailing ##########################
[smtp]
enabled = true
host = "smtp.gmail.com:587"
user = "<email-ID>"
# If the password contains # or ; you have to wrap it with trippel quotes. Ex """#password;"""
password = "<passoword>"
skip_verify = true
from_address = "<email-ID>"
from_name = "<name>"
```

*Note- Gmail need to be allowed access to [unsafe app](https://serverfault.com/questions/635139/how-to-fix-send-mail-authorization-failed-534-5-7-14).*

Also update the `root_url` values to the required domain name otherwise if you invite someone, they will get invitation link as `http://localhost:3000/abcdsef`.

*TIP- Search for it by presssing `/` in vim*
```
root_url = "http://domainname:port"
```

Once these changes are made restart the `grafana` service so as to apply the recent configuration changes. 

`sudo systemctl restart grafana.service`

## 2. Edit the dashboard
You can setup alerts in the dashboard itself on the required metrics.
I've imported the `Node Exporter Full` dashboard and now I want to set up alerts on disk space used. I want to be notified when I reach 80% of used disk space.
![](/images/2019-04-03-22-47-04.png)
*Node Exporter Full dashboard*

Now click on edit option after clicking on the down arrow key-ish button on **Disk Space Used**. You'll see something like this:-

![](/images/2019-04-03-22-50-10.png)

Click on the bottom-left **Bell** icon called **Alert** and then click **Create Alert**.

![](/images/2019-04-03-22-51-49.png)

The green graph shows the amount of free space left. Since I want to set the limit to >2 GB so I've set the values corresponding to **IS BELOW** to `2000000000` which is in Bytes. So it means that whenever the free-space left left will be <=2 GB I'll be notified. 

![](/images/2019-04-04-09-38-30.png)

Now add recipients of the alert mail and content in the bottom and you're done after you've saved it! *As simple as that! Now relax, you'll be notified whenever there's an emergency*
