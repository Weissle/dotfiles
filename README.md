# dotfiles

Nerd Font:
https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip

##

```sh
pip install tldr
```

# QA
## command prefix is duplicated.
```
$ cd 
# Then you press <TAB> you get cdcd, but the really content is still cd.
$ cdcd 
```
Solution: Remove the git_branch in `starship.toml`.