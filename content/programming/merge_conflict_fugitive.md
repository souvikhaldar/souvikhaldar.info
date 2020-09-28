---
title: "How to resolve merge conflict in vim"
date: 2020-09-28T21:19:12+05:30
draft: false
---
# Goal
Resolve the conflict arising out of merging two brances in vim.

# Requirements
* vim
* `vim-fugitive` plugin

# Steps to resolve the conflict

Once you have merged the brances, you can do `:Gstatus` inside vim to see the status of the files. 
1. Hit enter on the file whose conflicts you want to resolve.
2. The above step will open the file in a new buffer.
3. Go to the buffer in which the conflicted file is open then do `:Gvdiffsplit` to open the file in three way split as shown below.

![](/images/2020-09-28-21-26-19.png)

The left split is called the `target` branch, it is the current state of the file when we tried merging i.e current changes. The middle one is the `working` copy, where the resolved final state is captured. The right most split called the `merge` branch, it has the changes from the branch being merged to branch we are on i.e the incoming changes.
4. You can move to next conflict using `]c` and previous conflict using `[c`. 
5. On each conflict you need to decide which changes you want, either you can accept changes from the `target`branch by doing `:diffget //2` or you can accept changes from `merge` branch by doing `:diffget //3`, all from the `working` split. You can also you `:diffput` but I prefer `:diffget`.
6. If you want both changes, best options seems to to be manually copying from `target` and `merge` splits.
7. You can also use `:Gwrite` on either the `target` or the `merge` split you want that change entirely.
8. Once all conflicts are resolved, you can do `:only` from the split you want to keep and leave the `vimdiff` mode.
