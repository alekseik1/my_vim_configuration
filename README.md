# My personal VIM setup

Here you'll find instructions that I followed to obtain my current VIM installations.
Here are some screenshots:
![Screenshot_1](https://user-images.githubusercontent.com/11070318/58766917-440b8780-858d-11e9-9b33-dc4a8a91e9f6.png)
![Screenshot_2](https://user-images.githubusercontent.com/11070318/58766918-4c63c280-858d-11e9-9c55-26027fda7a59.png)

## Let's deploy!
Where are several steps you need to follow. Some of them include little hacks (like installation of _Powerline_ fonts)
but I'll provide all links to articles that describes such hacks very well.

More instructions can be found [here](https://github.com/junegunn/vim-plug/wiki/tutorial).

### `.vimrc` and plugin installation
1. Copy `.vimrc` from this repo to your `~/.vimrc` (if you are on **Linux** or **MacOS**) 
or to `${HOME}/.vimrc` (if on **Windows**)

2. Restart VIM instance. Type `:PlugInstall` for installing all plugins mentioned in `.vimrc`

3. Go to [hacks section](#hacks-section) for additional steps.
Where are some cosmetic actions you need to take.

### Undo history
We store undo history in special directory `~/.vim/undodir/`. Make sure to create it in advance:
```bash
mkdir ~/.vim/undodir/
```

## Hacks section
_These hacks are optional._ In each section, I'll give options how to handle without them if you want.


### Install `YouCompleteMe` plugin
As YCM has compilable component, you need to do some extra work described [here](https://github.com/Valloric/YouCompleteMe#installation).

If you don't want to install it, comment whole `YouCompleteMe` section in `.vimrc`

### Install `Powerline` fonts. 

If you are running in **WSL** (like me), you should refer to a 
[good article](https://medium.com/@jrcharney/bash-on-ubuntu-on-windows-the-almost-complete-set-up-1dd3cb89b794)
on Medium. It describes process very well.

In other cases, instructions [on official vim-airline](https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts) page should be enough.

**If you don't want to follow this step**, comment `let g:airline_theme='powerlineish'` in `.vimrc` file

## Further actions
If you have any ideas of optimizing suggested `.vimrc`, open an _Issue_.
