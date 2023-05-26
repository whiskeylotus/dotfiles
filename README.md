# My linux configuration

Once the repository is cloned, run ``install.sh``.

# Vim tips

## Save a file with sudo permissions

```bash
:w !sudo tee %
```

## Commands

```bash
# Undo : u
# Redo : Ctrl + r

# Copy from sytem clipboard  : "*y
# Paste from system clipboard: "*p

# Open file : :e

# Select block of code: vip (visual in paragraph)
# Select or move code alike: v% (select) % (move)
# Select last block: gv

# Indent by two a block (visual): > | >ip (indent in paragraph)
# Indent block : Vgq
# Put a block on one line (Visual mode): J (concatenate)
# Use another formatting tool for a block (Visual block): V!cmd
# Ex for json: V!jq

```
