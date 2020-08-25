---
title: "Migrating from Vim to Neo Vim"
date: 2020-08-25T16:03:52+05:30
draft: false
---
# Introduction
I've completely mmoved to vim for all my editing works (except for git conflict resolution for which I use vscode) for almost 3 months now and completely loving it. 
But recently I've been hearing about neo vim and how it is subtly better than vim. Hence today I thought of moving to neovim to give it a try, because vim is always there to switch back if I don't like.

# Process of migration
1. `brew install neovim`
2. Install `vim-plug` for managing plugins on neovim (I used to use this plugin manager only vim as well) `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`
3. Open nvim using `nvim` on terminal. I use `iterm2` as my default terminal emulator.
4. Run `:help nvim-from-vim` and follow the steps.
5. Copy the contents of `~/.vimrc` to the newly created `~/.config/nvim/init.vim`
6. Now `nvim` seems to be running exactly like `vim`

There is one benefit I can see right away after installing nvim is that, I used to run `:sh` to perform shell operations while inside vim, once done I would `exit` from shell and that would bring me back to `vim`, but used to create confusion as to what to do once in shell, shall I do `exit` or run `vim .` again!  
This issue seems to be fixed because you can't run `:sh` from nvim, let's see what's the workaround.
__P.S: This article is Work In Progress__
