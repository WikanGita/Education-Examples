#!/usr/bin/env bash

[ -f "~/.shrc" ] && ~/.shrc

#    .--.      .-'.      .--.      .--.      .--.      .--.      .`-.
# :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::
# '      `--'      `.-'      `--'      `--'      `--'      `-.'      `--'
#
#                               arguments
#
# --xfile       Path to xterm configuration file.
#               By default: $HOME/.xterm
#
# --cd          Set it to change directory.
#               By defauklt: $HOME
#
# --class       XTerm's class name
#               By default: XTerm
#
# --su          Username to switch to.
#
# --shell       Command to execute.
#               By default: sh
#
# --before      Commands to execute before --shell
#




#
#    .--.      .-'.      .--.      .--.      .--.      .--.      .`-.
# :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::
# '      `--'      `.-'      `--'      `--'      `--'      `-.'      `--'
#
#                           reading arguments
#

  ARG_XFILE="$HOME/.xterm"
  ARG_CD=$HOME
  ARG_SHELL=sh
  ARG_CLASS=XTerm
  ARG_SU=
  ARG_BEFORE=

  argument=""

  for var in "$@"; do

    if [ -n "$argument" ]; then
      eval "$argument=\"$var\""
      argument=""
      continue
    fi

    case "$var" in
      "--xfile") argument=ARG_XFILE ;;
      "--cd") argument=ARG_CD ;;
      "--shell") argument=ARG_SHELL ;;
      "--class") argument=ARG_CLASS ;;
      "--su") argument=ARG_SU ;;
      "--before") argument=ARG_BEFORE ;;
    esac

  done

#
#    .--.      .-'.      .--.      .--.      .--.      .--.      .`-.
# :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::
# '      `--'      `.-'      `--'      `--'      `--'      `-.'      `--'
#
#                       reading /--xfile/ file
#
#   The very important property in /--xfile/ is /?.vt100.settings/.
#   This is the only property this script is looking for.
#

  # Command string will contain all dynamic
  # calls and variables setup
  CMD_STRING=""

  # searching for /?.vt100.settings/ lines in /--xfile/.
  line="$(cat "$ARG_XFILE" \
       | grep -oE "^${ARG_CLASS}.vt100.settings(.+){1,200}" \
       | sed -e 's/ //g' \
       | head -n 1)"

  # going to read all /key=value/ attributes from /?.vt100.settings/ value
  for attr in $(echo $line | grep -Eo "[a-z]{1,40}=[a-zA-Z0-9_-]{1,100}"); do
    key="$(echo $attr | grep -Eo '^[a-z]{1,40}')"
    value="$(echo $attr | grep -Eo '[a-zA-Z0-9_-]{1,100}$')"
    case "$key" in
      "initsize")
        height="$(echo $value | grep -Eo '^[0-9]{1,4}')"
        width="$(echo $value | grep -Eo '[0-9]{1,4}$')"
        CMD_STRING="$CMD_STRING resize -s $height $width; clear;"
        ;;
      *)
        CMD_STRING="${CMD_STRING}export XTERM_${key^^}=$value;"
        ;;
    esac
  done

  [ -n "$ARG_BEFORE" ] && CMD_STRING="$CMD_STRING;$ARG_BEFORE"

#
#    .--.      .-'.      .--.      .--.      .--.      .--.      .`-.
# :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::
# '      `--'      `.-'      `--'      `--'      `--'      `-.'      `--'
#
#                         preparing session
#
#   Setting up given shell session or root login to given shell session.
#

  [ -n "$ARG_SU" ] && CMD_STRING="$CMD_STRING su -m $ARG_SU -c \"$ARG_SHELL\"" \
                   || CMD_STRING="$CMD_STRING $ARG_SHELL"

#
#    .--.      .-'.      .--.      .--.      .--.      .--.      .`-.
# :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::
# '      `--'      `.-'      `--'      `--'      `--'      `-.'      `--'
#
#                          launching XTerm
#

  cd "$ARG_CD"
  exec xterm -T XTerm -class $ARG_CLASS -e "$CMD_STRING"

