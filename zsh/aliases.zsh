alias cls="clear && ls"
alias gs="git status"
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
alias size="du -h . --max-depth=1"
alias http="python2 -m SimpleHTTPServer "
alias doc="/bin/d"
alias sshuttle="sshuttle --dns -vvr drakirus@drakirus.xyz 0/0"
alias STFU="pulseaudio -k && sudo alsa force-reload"
alias paclean="sudo pacman -Rns \$(pacman -Qqtd)"
alias backup="rsync -avP --cvs-exclude --exclude-from="$HOME/.rsync.excludes" ~/lab /run/mount/NAS/xps13-Backup/"
alias nas="sudo mkdir -p /run/mount/NAS; sudo mount -t nfs -rw 192.168.16.134:/volume1/Share /run/mount/NAS/"
alias unas="sudo umount /run/mount/NAS"
# alias cp="rsync -ah --partial --inplace --info=progress2"
alias tri="exiftool -if '\$rating >= 1' -d './Tri' '-directory<createdate' ."
alias bt="sudo systemctl start bluetooth.service"
alias neof="neofetch --memory_display barinfo"
alias grip="grip --pass afab9ab158c3a52283f9bf2adfc2b6a3fe6286b2"
alias weeb_send="rsync -vP ~/Weeb/* drakirus@drakirus.xyz:APP/data/www/gif"
alias drak="ssh drakirus@drakirus.xyz"
alias mv="mv -iv"
alias cp="cp -aiv"
