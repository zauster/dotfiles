

########################
##### Some aliases #####
########################

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=C'
    alias grep='grep --color=auto'
    #alias vdir='ls --color=auto --format=long'
fi

alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'

alias ll='ls -l'
alias la='ls -al'
alias l='ls -CF'

alias hg='history | grep'
alias pag='ps aux | grep'
alias initLeftDisplay='xrandr --output HDMI1 --mode 1280x720 --left-of eDP1'
alias shutLeftDisplay='xrandr --output HDMI1 --off'
alias initRightTV='xrandr --output HDMI1 --auto --right-of eDP1'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# alias dbupd="dropbox stop; rm -rf ~/.dropbox-dist; dropbox start -i"

### git aliases ###
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'

# Pacman alias examples
alias pacupg='sudo pacman -Syu' #; sudo pacman -Sc --noconfirm'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacs='pacman -Ss'                # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
alias pacclean='sudo pacman -Sc'            # Clean the local cache from old packages
alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias pacro='sudo pacman -Rs $(pacman -Qtdq)' # Removes unneeded packages
#alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

alias emacsen='emacsen -nw'

##
## yaourt aliases
##

alias yass='yaourt -Ss'
alias yapg='yaourt -Syua'
alias yas='yaourt -S'
alias yarem='yaourt -Rns'


#####################
#### aliases end ####
#####################
