# all my dotfiles

tbh its just a neovim setup with some extra stuff.

## install

anyways dl + install neovim 0.9+
id probably use zsh + oh-my-zsh. since im me, i think i'll do that. ensure i have additionally installed:
* zig
* some kinda fuzzy find (fzfind or fz or something)
* go
* rust
* node (20 as default to support all the node lsps) with volta cuz i have way too many different node repos
  - super sad note - locally scoped volta installs to node14 can break lsps written in js that do annoying shit like use ??= in their code
* python (add setup tools to global env cuz python made a very stupid breaking change in a recent 3.minor version)
  - im not sure why python didnt think people would assume that their library that relied on BUNDLED PYTHON LIBRARIES would not attempt to double install those in their venv
  - this was such an annoying change, why did they think this was only deserving of a minor patch

i should just use go lol

``` sh
cp -r ~/path/to/repo/dotfiles/.config ~/
```

open neovim and wait for it to dl everything. note that neovim is still kinda crappy since lsps can run into major errors and not realize
they need to reparse the whole buffer. just reopen neovim, generally always fixes. most frequently occurs when making a major config / project
setup level change while in neovim.

## recent update improvements

restored ctrl r

restored \<leader\>fd functionality - now based on git files 

added a slightly better version of hyper + a new colorscheme command - \<leader\>fc

big files is supported now with a new plugin - 2MB+ files wont have e.g. treesitter and lsps get attached.

better automatic support for new setup.

cleaner UI, removed hyper cuz it just annoyed me

## current, most important features/plugins

this is in order of how much i care about it.

* automatic lsp installation / attachment / configuration (so easy to add new lsps/linters/formatters now with mason)
* treesitter
* buffers in tabs
 - harpoon better?
* terminal in floating buffer \<leader\>tt and \<esc\> / \<leader\>tt to close
* git blame inline
* map ctrl f + ctrl r + ctrl s to work similarly to everywhere else
* telescope with fuzzy finding
  - supports ignoring git files + hidden files for file name searching with \<leader\>ff
  - supports grepping active directory with \<leader\>fg
  - supports all file name searching with \<leader\>fa
  - \<leader\>fd is broken ;_;
* highlighting text on copy (you have no idea how useful this is lol)
* autocomplete on the right button, i disagree with everyone that doesnt use the right button. there is only one button.
* large files
* mouse enable (yeah idk, i just always end up using it a bit)

## my current irritations

keep adding things to this list til ive gone completely nuts

* should add a new landing page that doesnt change projects on me - i dont like projects, just start neovim in the right (write lol) directory duh.
* fix ctrl r
* fix \<leader\>fd - its not picking up dot files anymore, like why my brain dumb?
* write a paste hotkey / autocmd that maintains to-paste buffer (wtf is the default to copy over the newly deleted buffer, who wants that??????????????????????????????????????????????????????????????????????????????????????) (primeagen?)
* better snippets - i haven't gotten it working well yet, not sure i ever liked snippets tho...
* use / find refactor code actions for highlighted buffers. forgot that i like that one (e.g. move v-buffer lines to a newly named fn in same namespace)
* figure out a way to open the same file in a separate buffer (should i just use, idk harpoon mapped to f keys? ugh)
