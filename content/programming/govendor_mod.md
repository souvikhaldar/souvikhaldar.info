---
title: "How to migrate dependency management to go modules in a Golang project"
date: 2019-04-05T14:19:52+05:30
draft: false
---
## Introduction
Go didn't had any official dependency management tool till the version 1.10, but gophers heavily used the third party dependency management tools like [govendor](https://github.com/kardianos/govendor),[dep](https://github.com/golang/dep),etc. In late 2018, [go modules](https://github.com/golang/go/wiki/Modules) was introduced as an experimental dependency management tool in the version 1.11 and since then it has proved it's mettle and now in 2019 it has become the official one. 
You can get plenty of resources online which talks about how to get started with `go modules` but here I'm going to talk about how to migrate a project's dependency management from `govendor/dep` to `go modules`.

## Structure
A module can be thought of as the project. The module `github.com/souvikhaldar/example` is described in it's `go.mod` file. A module comprises of packages. Each package can be imported by users by doing, for example `go get github.com/souvikhaldar/example/pkg`. There are four directives in a module:-

1) module --> Determines the path of the module 
   
2) require --> Determines all the dependencies required 
   
3) [replace](https://github.com/golang/go/wiki/Modules#when-should-i-use-the-replace-directive) --> Allows to supply another import path that might be a module in another VCS or in local file system  
   
4) exclude --> To exclude specific version of a dependency

**Note- Check the version of the packages for satisfaction  by doing `go list -m all`**

## Migration
`go modules` has [native support](https://github.com/golang/go/wiki/Modules#automatic-migration-from-prior-dependency-managers) for migration from several dependency managers like govendor,dep,glide,etc. You need to perform a simple one liner:- 
`go mod init` , this will read and translate `vendor` file and create appropriate `go.mod` file.

**A major point of writing this article is that, while doing this migration I was stuck at an issue, and the issue is that I have some packages required, which are local only, hence it worked with `GOPATH` but now since `GOPATH` is gone, I need a workaround.**

Here comes the requirement of `replace` directive as mentioned above.

### Situation 
I have a dependency requirement of a package called `gitlab.com/multitech/go_server/config` which is local package.

![](/images/2019-04-19-13-21-31.png)

### Solution
In order to import this I need to `replace` this import path with the absolute or relative path of the module which provides this package and also mention this in the `require` directive.

* Add --> `gitlab.com/multitech/go_server v0.0.0` in the require section.

* Add --> `replace gitlab.com/multitech/go_server => <absolute or relative path>/go_server` at the bottom.
  
  ![](/images/2019-04-21-13-09-18.png)

This solves two major steps that are often required while migrating the dependency management tool. I'll update this article with more hurdles that might come in the way while I work with modules more.

Moving ahead, read this brilliant article by Russ Cox on [go modules](https://research.swtch.com/vgo-module).


