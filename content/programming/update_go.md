---
title: "How to update Golang"
date: 2019-04-11T10:33:26+05:30
draft: false
---

   * For updating golang, you need to first [uninstall golang](https://golang.org/doc/install#uninstall).
        Check where is the `go` directory. Run `which go`. The output might be similar to:-

        
        souvik:Development souvikhaldar$ which go
        /usr/local/bin/go
        
   * Delete the directory as is the output above.
  
        
        sudo rm -rf /usr/local/bin/go
    
   * Now install the required version. Visit [this link](https://golang.org/doc/install)
   * Check the version by running :-

        souvik:~ souvikhaldar$ go version
        go version go1.12.3 darwin/amd64