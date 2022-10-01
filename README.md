# XKCDCLI

## NAME

xkcdcli - Command line interface to view XKCD comics

## SYNOPSIS

`xkcdcli [-andlict] [NUMBER]`

## DESCRIPTION

Draws a frame with the title and transcript of the comic number NUMBER.

Optionally can download the actual image file.

## CONFIGURATION

Coming soon...

The config directory is:

On Linux `$XDG_CONFIG_HOME` or `$HOME/.config`

On MacOs `$HOME/Library/Preferences`

## OPTIONS

**a**, **all** :print all information,

**n**, **no-draw** :do not draw comic in the terminal,

**d**, **date** :get the publication date of the comic,

**l**, **link** :get the link to the comic,

**i**, **img-link** :get a link to just the image file,

**c**, **content** :get the transcript as plain text,

**t**, **title** :get title of the comic,

**alt-title** :get alternative title,

**o**, **out-file** :download the image and use this for file name,

**download** :get alternative title,

## BUGS

Sometimes the frame gets moved by the excess text.

Report other bugs [on GitHub](https://github.com/dk949/xkcdcli/issues).
