---
title: "Moving from govendor/dep to go modules"
date: 2019-04-05T14:19:52+05:30
draft: true
---

Go didn't had any official dependency management tool till the version 1.10, but gophers heavily used the third party dependency management tools like [govendor](https://github.com/kardianos/govendor),[dep](https://github.com/golang/dep),etc. In late 2018, [go modules](https://github.com/golang/go/wiki/Modules) was introduced as an experimental dependency management tool in the version 1.11 and since then it has proved it's mettle and now in 2019 it has become the official one. 
You can get plenty of resources online which talks about how to get started with `go modules` but here I'm going to talk about how to migrate a project's dependency management from `govendor/dep` to `go modules`.

`go modules` has [native support](https://github.com/golang/go/wiki/Modules#automatic-migration-from-prior-dependency-managers) for migration from several dependency managers like govendor,dep,glide,etc. You need to perform a simple one liner:- 
`go mod init` , this will read and translate `vendor` file and create appropriate `go.mod` file.

A major point of writing this article is that, while doing this migration I was stuck at an issue, and the issue is that I have some packages required, which are local only, hence it worked with `GOPATH` but now since `GOPATH` is gone, I need a workaround.