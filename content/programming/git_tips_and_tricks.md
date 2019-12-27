---
title: "Git tips and tricks"
date: 2019-08-02T19:20:36+05:30
draft: false
---
`Git` is arguably the foundation tool of *Open Source* and software engineering (VCS) part in general, second biggest gift of [Linus Torvals](https://en.wikipedia.org/wiki/Linus_Torvalds) to the world after the mighty `Linux`! If you are new to the world of OSS, `git` is probably the first tool you should learn about! While getting starting with `git` is very easy, mastering `git` is a lifetime endeavour! So this article would be forever in WIP, I'll keep adding notes to it, so that anyone (including me) can keep visiting.  

* If you want to set a particular file to some branch's version on origin without disturbing other files in the branch you can use `git checkout origin/<branch-name> --path/to/the/file`.  
For eg, if I want to set xyz.go file to the master version you can do:-  
`git checkout origin/master --xyz.go`  

* Sometimes, we are not ready to commit yet but want to change the branch or we realise that we have been making changes in a wrong branch. In that case `git stash` can be useful. What is does is, it saves your current changes in a stack and makes the status clean (i.e no `diff`). Now you can change your branch or do whatever is needed, and then when you want those stashed changes back, you `apply` selected stash from the stack.  
    1. To save current changes to the stack `git stash save "message"`. 
    2. List all the saved changes in the stack `git stash list`.  
        ![](/images/2019-08-02-20-01-06.png)   
    3. To apply the selected stash `git stash apply <stash id>`.
        ![](/images/2019-08-02-20-04-02.png)
    4. If you want to apply last saved stash `git stash pop` (same concept as stack ADT)  
    5. If you want to delete particular stash `git stash drop <stash-id>`.  
    6. If you want to delete all the saved changes in you stash `git stash clear`.  

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
    
* If you want to create a new branch out of a remote branch you can use:-  
    `git checkout -b <new-branch> origin/<source-branch>`  

* If a branch `feature`,`bug`,etc branch of yours is very behind than `develop` or `master` (whatever is the eventual target), then doing `merge` (by `git pull origin <master/develop>`) is less troublesome than `rebasing`. Although, under normal conditions `rebase` is better alternative to `merge` since it keeps the git history pristine. 