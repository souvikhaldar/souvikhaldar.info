---
title: "How to paste screenshot in vim buffer on Ubuntu"
date: 2020-11-01T00:30:30+05:30
draft: false
---
# Goal	
In markdown files, you can insert an image by writing `![alt text](/path/to/image)`, but doing this task manually is quite cumbersome. Let me state the manual steps first to make you understand why this is cumbersome.  
1. Take screenshot  
2. Save it at proper location  
3. Mention the image in the markdown using the above mentioned syntax, i.e `![]()`  

Now, I wanted to complete the all the above steps in least number of keystrokes, in one step! Let me explain how I did it, then I'll also explain what challenges I faced in the meanwhile. All the steps were performed on Ubuntu 20, hence it might differ from OS to OS. Also, this was a great learning experience for me, hence want to document it the best way possible.

# Procedure
I thought of trying out [this vim plugin]() but it was surprisingly not working. Then I read the documentation properly which led me to the genesis of this plugin which is [this stack exchange answer](https://vi.stackexchange.com/a/14117/30129). Then I following this answer, understood the vimscript then added it to my `vimrc` but, it was still not working :(  
Upon investigating it further I readlized that it was missing `!` infront of `[]()` while inserting the image in the script, but, even after updating the vimscript it was still not working!  
Then I tried to figure out if my [vim system register](https://vim.fandom.com/wiki/Accessing_the_system_clipboard) was working properly. It turns out my vim version does not support clipboard! (You can check this by running `vim --version | grep clipboard`, then see it is `-clipboard` or `+clipboard`). Hence I had to install `vim-gtk` to enable this feature. I've [raised an issue in the project to specify this issue](https://github.com/ferrine/md-img-paste.vim/issues/47). Now I was able to paste the data stored in system clipboard to vim buffer and vice-versa.  
But it turns out I was still not able to copy screenshot using the default tool, but able to paste in vim buffer yet. Now I need to solve the copy problem!  
Ubuntu has `gnome-screenshot` which allows you to capture portion of the screen (IMHO most flexible way to take screenshot) and then paste it anywhere I want. But, after lots of frustration I understood that `gnome-screenshot` is taking the screenshot but it is not being copied to `xclip` clipboard manager which is what I am using to paste the screenshot in vim buffer. I order to get around this I had to [assign a keyboard shortcut to the following command to take screenshot and place it in xclip](https://askubuntu.com/a/1212806)
Ultimately now it worked! Now I can take screenshot using the custom keyboard shortcut (which pops up a terminal too) and then paste it using `<leader>p` in vim since I have mapped it this way in my vimrc.  
# Conclusion
It was complicated and took me a lot of time to figure it out. It you find similar issue, [tweet](https://twitter.com/s0uvikhaldar) to me or DM me on [LinkedIn](https://www.linkedin.com/in/souvikhaldar/), I would be happy to help!


