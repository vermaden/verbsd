# IMPORT doas(1) OR sudo(8) CONFIG
  if [ -f ~/.zshrc.DOAS.SUDO ]
  then
    source ~/.zshrc.DOAS.SUDO
  else
    echo "NOPE: File ~/.zshrc.DOAS.SUDO absent."
  fi

# BASICS
  export PATH=${PATH}:~/scripts:~/scripts/bin:~/.cargo/bin:~/.local/bin
  export EDITOR=vi
  export VISUAL=vi
  export BROWSER=firefox
  export MANWIDTH=tty
  export ENV=${HOME}/.shrc
  export TZ=Europe/Warsaw

# BASICS DESKTOP
  export DISPLAY=:0
  export MOZ_DISABLE_IMAGE_OPTIMIZE=1
  export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
  export NO_AT_BRIDGE=1

# LIMIT cargo(1) TO 1 CPU CORE
  export CARGO_BUILD_JOBS=1

# ENABLE ICONS IN exa(1)
  case ${TERM} in
    (rxvt)   :                       ;;
    (xterm*) alias exa='exa --icons' ;;
    (*)      alias exa='exa --icons' ;;
  esac

# ALIASES
  RE='((25[0-5]|2[0-4][0-9]|[01]?[1-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[1-9][0-9]?)'
  RM='((25[0-5]|2[0-4][0-9]|[01]?[1-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[1-9][0-9]?)([/]([8-9]|[12][0-9]|3[0-2]))?'
  alias ipregex="env GREP_COLOR=34 grep --color -C 256 -E '${RM}'"
  alias aria2c='aria2c --file-allocation=none'
  alias bat='bat --color=always --style=plain'
  alias caja='caja --browser --no-desktop'
  alias cclive='cclive -c'
  alias cls='printf "\033[H\033[J"'
  alias cssh='cssh -o "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"'
  alias dd='dd status=progress'
  alias dfg='df -g'
  alias dig=drill
  alias dosa=doas
  alias duf='duf -style ascii'
  alias e=exa
  alias f='find . | fzf -m -e'
  alias evince=atril
  alias ffmpeg='ffmpeg -hide_banner'
  alias gcp='gcp --sparse=always'
  alias Grep=grep
  alias grpe=grep
  alias less='less -S -X -K'
  alias lp='/usr/local/bin/lp'
  alias lsof='lsof -w'
  alias lupe='lupe -noshape -mag 2 -nohud -geometry 300x200 -noreticle -noiff'
  alias midori='midori -p'
  alias more='less -F -S -X -K'
  alias mupdf='mupdf -r 120'
  alias mnt=mnt.sh
  alias mix=mix.sh
  alias nv='nc -v'
  alias open=xdg-open
  alias pbcopy=' xclip    -selection clipboard'
  alias pbpaste='xclip -o -selection clipboard'
  alias parallel='parallel --no-notice --progress -j 3'
  alias pstree='pstree -g 2'
  alias pv='pv -t -r -a -b -W -B 1048576'
  alias qr='qrencode -t ansiutf8'
  alias tac='tail -r'
  alias jails="${CMD} jails.sh"
  alias j=jails
  alias camera0='pwcview -d /dev/video0 -s uxga -f 30'
  alias camera1='pwcview -d /dev/video1 -s uxga -f 30'
  alias camera2='pwcview -d /dev/video2 -s uxga -f 30'
  alias camera3='pwcview -d /dev/video3 -s uxga -f 30'
  alias wine64='env WINEPREFIX=/home/vermaden/.wine64 WINEARCH=win64 wine64'
  alias winecfg64='env WINEPREFIX=/home/vermaden/.wine64 WINEARCH=win64 winecfg'
  alias we="fetch -o - http://wttr.in/Lodz 2> /dev/null | sed -e '\$d' | sed -e '\$d'"
  alias x='xinit ~/.xinitrc -- -dpi 75 -nolisten tcp 1> /dev/null 2> /dev/null'
  alias dl='      youtube-dl                                                                                        --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias dl-old='  youtube-dl                                                                                        --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias yu='      youtube-dl                                                                                        --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias yu-old='  youtube-dl                                                                                        --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias dlf='     youtube-dl                                                         --cookies-from-browser firefox --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias dlf-old=' youtube-dl                                                         --cookies-from-browser firefox --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias yuf='     youtube-dl                                                         --cookies-from-browser firefox --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias yuf-old=' youtube-dl                                                         --cookies-from-browser firefox --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias dlc='     youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]"                                --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias dlc-old=' youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]"                                --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias yuc='     youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]"                                --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias yuc-old=' youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]"                                --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias dlcf='    youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]" --cookies-from-browser firefox --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias dlcf-old='youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]" --cookies-from-browser firefox --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias yucf='    youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]" --cookies-from-browser firefox --trim-filenames 80 -c -i      --skip-unavailable-fragments'
  alias yucf-old='youtube-dl -f "bestvideo[height=1080]+bestaudio/best[height=1080]" --cookies-from-browser firefox --trim-filenames 80 -c -i -f b --skip-unavailable-fragments'
  alias ssh='ssh -C -c aes128-ctr -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
  alias sshfs='sshfs -C -o max_conns=2'
  alias scp='scp -o ControlMaster=yes \
                 -o ControlPath=/tmp/%r@%h:%p \
                 -o UserKnownHostsFile=/dev/null \
                 -o StrictHostKeyChecking=no'
  alias wget='wget -c --no-check-certificate \
                   -U "Opera/12.16 (X11; FreeBSD 4.11 amd64; U; en) Presto/3 Version/12"'
  alias feh="feh --scale-down \
                 --auto-rotate \
                 --auto-zoom \
                 --fontpath ~/.fonts \
                 --font       ubuntu/8 \
                 --menu-font  ubuntu/8 \
                 --title-font ubuntu/8"

# MANUAL AUTOMOUNT
  function amnt() { # 1=DEV
    ${CMD} /usr/local/sbin/automount ${1} attach
  }

# BROOT
  if [ -f /home/vermaden/.config/broot/launcher/bash/br ]
  then
    source /home/vermaden/.config/broot/launcher/bash/br
  fi

