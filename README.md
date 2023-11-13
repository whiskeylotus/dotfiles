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

## Cheatsheets

```
- "u" undo
- "I" passer en mode Insert au début de ligne
- "A" passer en mode Insert en fin de ligne
- "o" passer en mode Insert à la ligne suivante
- "O" passer en mode Insert à la ligne précédente
- "dd" couper une ligne complètement
- "yy"copier une ligne complètement
- "p" coller ce qui a été couper/copier
- :153 aller à la ligne 153 directement
- / pour faire une recherche
- ctrl+r : redo
- "a" mode Insert juste après le curseur
- "gg" aller à la 1ere ligne
- "G" aller à la dernière ligne
- "0" aller au début de la ligne
- "$" aller à la fin de la ligne
- "w" aller au mot suivant
- "dw" couper le prochain mot
- "2dw" couper les deux prochains mots
- "." refaire la dernière commande faite
- "3y⬇️" copier 3 lignes en allant vers le bas
- "4." refaire la dernière commande 4 fois
- ctrl+a ajouter 1 au premier nombre rencontré sur la ligne
- ctrl+x enlève 1 au premier nombre rencontré sur la ligne
- "d$" supprimer du curseur à la fin de la ligne
- "d0" supprimer du curseur au début de la ligne
```
