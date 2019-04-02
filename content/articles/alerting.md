---
title: "Alert Manager in Prometheus"
date: 2019-04-02T14:48:56+05:30
draft: false
---

# Setting up SMTP
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
Also update the `root_url` values to the required domain name otherwise if you invite someone, they will get invitation link as `http://localhost:3000/abcdsef`.
**TIP- Search for it by presssing `/` in vim**
```
root_url = "http://domainname:port"
```

Once these changes are made restart the `grafana` service so as to apply the recent configuration changes. 

`sudo systemctl restart grafana.service`

## DEMO

![](images/2019-04-02-22-28-06.png)