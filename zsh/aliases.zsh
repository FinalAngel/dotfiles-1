alias cls="clear && ls"
alias gs="gdstst"
alias gau="git add -u"
# alias e="thunar &> /dev/null &"
alias e="thunarCmd > /dev/null 2>&1"
alias tmux="TERM=screen-256color-bce tmux "
alias x=extract  #Function extract
alias q="exit"
alias dc="docker-compose"
alias wifi="killall nm-applet; nm-applet > /dev/null 2>&1 &; disown"
alias stfu="amixer -c 0 cset 'numid=10' 1"
alias zup3x="~/lab/python/zup3x/zup3x.py -kl 'qwerty' -u CHAMPI16 -p 80948"
alias size="du -h --max-depth=1 . | sort -h"
alias http_serv="python2 -m SimpleHTTPServer "
alias doc="/bin/d"
alias sshuttle="sshuttle --dns -vvr drakirus@drakirus.xyz 0/0"
alias STFU="pulseaudio -k && sudo alsa force-reload"
alias paclean="sudo pacman -Rns \$(pacman -Qqtd)"

# NAS
alias backup-lab="rsync -avPh --cvs-exclude --exclude-from="$HOME/.rsync.excludes" ~/lab /run/mount/NAS/xps13-Backup/"
alias backup-music="rsync -avPh --cvs-exclude --exclude-from="$HOME/.rsync.excludes" ~/Musique /run/mount/NAS/xps13-Backup/"
alias backup-image="rsync -avPh --cvs-exclude --exclude-from="$HOME/.rsync.excludes" ~/Images /run/mount/NAS/xps13-Backup/"
alias backup-resource="rsync -avPh --cvs-exclude --exclude-from="$HOME/.rsync.excludes" ~/resource /run/mount/NAS/xps13-Backup/"
alias nas="sudo mkdir -p /run/mount/NAS; sudo mount -t nfs -rw 192.168.16.146:/volume1/Share /run/mount/NAS/"
alias unas="sudo umount -l /run/mount/NAS"

# alias cp="rsync -ah --partial --inplace --info=progress2"
alias tri="exiftool -if '\$rating >= 1' -d './tri' '-directory<createdate' ."
alias bt="sudo systemctl start bluetooth.service"
alias neof="neofetch --memory_display barinfo"
alias grip="grip --pass afab9ab158c3a52283f9bf2adfc2b6a3fe6286b2 -b"
alias weeb_send="rsync -vPh ~/Weeb/* drakirus@drakirus.xyz:APP/data/www/gif --rsh='ssh -p2242' "
alias resume_send="test -f ~/Téléchargements/resume.pdf && mv ~/Téléchargements/resume.pdf ~/lab/resume/resume.pdf; rsync -vPh ~/lab/resume/resume.pdf drakirus@drakirus.xyz:APP/data/www/resume --rsh='ssh -p2242'"
alias mv="mv -iv"
alias cp="cp -aiv"
alias py="python"
alias py2="python2"
alias docker_alpine="docker run -it --rm alpine /bin/ash"
alias music="mpv ./* --shuffle"
alias df="df --type=ext4 -h"
alias mip="curl --silent ifconfig.co/json | prettyjson"
alias de="adb devices"
alias de-screen="adb exec-out screencap -p > screen.png"
alias de-screen1="adb exec-out screencap -p > screen1.png"
alias de-screen2="adb exec-out screencap -p > screen2.png"
alias co="cordova"
alias rm='trash'
alias loc='tokei'

alias lowwifi='sudo iwconfig wlp58s0 txpower 15'

# CVS svn
alias sg="colorsvn status"
alias sc="colorsvn commit"
alias sl="colorsvn update"

alias ju="LC_ALL=en_US.UTF-8 jupyter notebook"

alias goo="google-chrome"

alias t="cd /tmp"
alias tl="cd ~/Téléchargements"

alias ms="LC_ALL=en_US.UTF-8 minishift"

alias tb="netcat termbin.com 9999 | xclip -selection c"

alias ncdusys="sudo ncdu / --exclude \"/home/*\" --color dark -rr -x --exclude .git --exclude node_modules"
alias ncdu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

alias atal="ssh s142293@transit.univ-lemans.fr"
alias webai="ssh dialog@172.16.250.7"
alias drak="ssh drakirus@drakirus.com -p 2242"

alias pdf="zathura --fork"

# alias cat="bat --theme=GitHub"
alias ping='prettyping --nolegend'
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'

alias cb='ruby ~/lab/ruby/credit_mutuel/credit_mutuel_monitor.rb'

############
#  Editor  #
############

alias vim="nvim"
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then

fi
