---
title: "How to install a package on linux using Golang"
date: 2019-10-29T02:08:46+05:30
draft: false
---
# Why
Recently I was trying to write a script in golang that would install a package on my Ubuntu server. I did know that `os/exec` library allows you to run a command but I was unsure as to how should I actually frame the command so that it can do the installation. So, this is not guide will show a snippet showing how can you install a package using the OS's package manager using golang.  
# How
Let me show an example so that it becomes easy to understand. Suppose I want to install on ubuntu, I would do it this way.  
```
c := exec.Command("/bin/sh", "-c", "sudo apt-get install prometheus-node-exporter")
		if err := c.Run(); err != nil {
            fmt.Println("Error in installation: ", err)
		}
	}
```
First argument to `Command` specifies why shell to use, man says `-c` flag is for - "Read commands from the command_string operand instead of from the
                            standard input.  Special parameter 0 will be set from the command_name
                            operand and the positional parameters ($1, $2, etc.)  set from the
                            remaining argument operands." and finally the command for installing `prometheus-node-exporter` using `apt-get` package manager.  
Similarly, we can do execute other commands following the same design.
