# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# golang
export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# android SDK tools
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

# Shopify Theme setup
# http://themekit.cat/install/#unix-like
export PATH=~/Applications/bin:$PATH

# nodenv
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

local _old_path="$PATH"

# FZF respect .gitignore t.ly/PjM38
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
#
# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

if [[ $PATH != $_old_path ]]; then
  # `colors` isn't initialized yet, so define a few manually
  typeset -AHg fg fg_bold
  if [ -t 2 ]; then
    fg[red]=$'\e[31m'
    fg_bold[white]=$'\e[1;37m'
    reset_color=$'\e[m'
  else
    fg[red]=""
    fg_bold[white]=""
    reset_color=""
  fi

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

cat <<MSG >&2

${fg[red]}Warning:${reset_color} your \`~/.zshenv.local' configuration seems to edit PATH entries.
Please move that configuration to \`.zshrc.local' like so:
  ${fg_bold[white]}cat ~/.zshenv.local >> ~/.zshrc.local && rm ~/.zshenv.local${reset_color}

(called from ${(%):-%N:%i})

MSG
fi

unset _old_path
