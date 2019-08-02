---
title: "Git tips and tricks"
date: 2019-08-02T19:20:36+05:30
draft: false
---

* If you want to set a particular file to some branch's version on origin without disturbing other files in the branch you can use `git checkout origin/<branch-name> --path/to/the/file`.  
For eg, if I want to set xyz.go file to the master version you can do:-  
`git checkout origin/master --xyz.go`  


* Cherry-picking in git:-  
	
	In git if you have the commit ID of a commit you can use it in any branch/MR/PR.
	Steps:-
    * Copy the commit ID of the commit that you want to use somewhere else.
    * Go to the required branch, then do `git cherry-pick <ID>`.
    * That commit will be added to the current branch.

*  If you want to go back to a certain commit in git do :-  
    `Git reset --hard <commit-hash>`

* If you want to undo the changes made in a certain commit do :-  
    `Git revert <commit-hash>`
