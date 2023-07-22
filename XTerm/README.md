# ABOUT

  This directory contains example configuration of XTerm program.
  There is additional *xterm-run.sh* script to provide some more
  functionality. This script isn't required to configure or use 
  configured XTerm.

  Example configuration explains how to setup colors and fonts.
  There is configuration for copy and paste key bindings too
  so SHIFT+Insert paste and mouse selection copies text.

  Provided configuration file contains 8 configured XTerm classes.
  For more information about classes and usage read next two sections.

  Here is a screenshot of all XTerm classes ran in the same time:
  ![screenshot](https://github.com/WikanGita/Education-Examples/blob/main/XTerm/screenshot.jpg)

# HOW IT WORKS

  XTerm is a X11 application. Not GTK or QT but X11.
  This mean as any X11 application it use ~/.Xdefault
  file to configure many aspects of X application.

  Probably for most people X apps look bad. Poor font rendering,
  leak of antialiasing, ugly look. By default it is true.

  But. But it is possible to change that. All what you need
  is to edit ~/.Xdefault file.

  Of course it does nothing because ~/.Xdefault doesn't work
  as standard config file. By standard I mean the file that is read
  by program.

  X apps do not read ~/.Xdefault. This file is for X server and must
  be loaded manualy by user.

  To load ~/.Xdefault setup you need to use *xrdb* program:

  ```sh
    xrdb -load ~/.Xdefault
  ```

  This folder contains *xterm.conf* file not Xdefault. It is
  because you decide what file you want to use as a source
  of your X apps configuration.

  This mean you can save xterm.conf as ~/.xterm.conf and merge
  it with previously loaded Xdefault:

  ```sh
    xrdb -merge ~/.xterm.conf
  ```

  First command loads Xdefault file what means all previous
  configuration is reset to defaults before loading setup from 
  given file.

  Second command merges prviously loaded settings with another
  source of configuration, .xterm.conf.

  Xrdb comand must be launched manualy by user otherwise default,
  poor and ugly setup will be in use. 

  All what you need is to find a way to execute these two commands
  on you desktop startup.

  Remember. Any time you change anything in any loaded or merged
  files you must run xrdb command again but don't use -load.
  Merge (-merge) file instead of loading it otherwise all other
  settings from all other file will be removed.

# CLASSES

  The class is something like an object with its own properties.
  All properties are called resources and you can change and set
  their values.

  *XTerm* is default class. When user launch XTerm application
  *XTerm* class is used. This is the only one class that is hardcoded.

  Other classes may be defined by user, so I configured these:
  - XTerm
  - XTermApp
  - XTermAppFloat
  - XTermMan
  - XTermDo
  - XTermLight
  - XTermLightApp
  - XTermRoot

  You can change names and use your own.

# xterm-run.sh

  Read this file. At the top of the file is a list of supported
  run-time console arguments.

  I use this script to launch XTerm sessions.

  For example, this is my i3 key binding I use to open another
  script that generates passwords for me:

  ```
    ...
    bindsym g exec \
      xterm-run \
        --class XTermAppFloat \
        --xfile "$HOME/.xterm" \
        --shell "$HOME/.pkg/repo/static/uniscripts/generate-password.sh"; \
    ...
  ```

