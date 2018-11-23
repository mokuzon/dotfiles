dotfiles
====
My dotfile settings and manage script.

## Requirement
**Not** Windows and BSD.

## Usage
```
./manage.sh [option] [comment]
  options:
    init:   Install some tools and settings. It must be called at first time.
    pull:   Update settings from GitHub.
    commit: Update settings at local. git commit -m [comment] (default: 'update')
    push:   Push local settings to GitHub.
```

## Install
`bash -c "$(curl -fsSL https://raw.githubusercontent.com/mokuzon/dotfiles/master/manage.sh)" -s init`

## Licence

This software is released under the MIT License, see LICENSE.txt for details.

## Author

[mokuzon](https://github.com/mokuzon)
