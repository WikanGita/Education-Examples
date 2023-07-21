# ABOUT

  Xterm may look very well if you know how to configure it.
  Not only that, because it is possible to create multiple
  configurations for different XTerm classes.

  The class is something like your own named setup you can choose
  when you launching XTerm. You can prepare light and dark theme,
  setup different sizes of fonts and much more.

  This is example repository to teach you this.

# FILES

  ## xterm.conf

  Example configuration for xterm. Generally it is ~/.Xdefault file
  but it may be kept under different name. Especialy if you use
  ~/.Xdeefault to setup more apps.

  I use additional *.settings attribuite to setup environment
  and it is used by xterm-run.sh

  ### *.settings

  It is a list of key-value options. And they are:
  - initsize - initial size of terminal
  - colorscheme - information if theme is light or dark
  - mode - information if session is user or admin

  For example, you can use colorscheme in your vim script
  to set different vim's colorcsheme for light and dark terminal.

  ## xterm-run.sh

  Script helps to launch xterm by reading *.settings attribute.
  Read the script's header to learn about arguments.

# EXAMPLE CLASSES

  I made few example classes like:
  - XTerm         - the default one that works without -class
  - XTermApp      - like XTerm but without padding
  - XTermAppFloat - XTermApp with different class name
                    just for i3 rule that makes window floating
                    by default
  - XtermRoot     - With red background to make root session
                    look different
  - XTermMan      - Nice yellow-ish background for man pages.
                    (I open man pages from rofi)
  - XTermLight    - Light theme
  - XTermLightApp - XTermLight without padding
  - XTermDo       - Bigger fonts

# USAGE

  Without xterm-run.sh (no *.settings supported):

  ```sh
    xterm -class YourClassName
  ```

  With xterm-run.sh

  ```sh
    xterm-run.sh --class YourClassName --shell bash
  ```

  Before using your configuration you need to load or merge
  X settings. Put it to your startup file:

  ```sh
    xrdb -load ~/.Xdefaults
    xrdb -merge ~/.xterm.conf
  ```

