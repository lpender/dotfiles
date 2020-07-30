# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Git Setup
export GIT_EDITOR=vi

# Pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# direnv
eval "$(direnv hook zsh)"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# fnm
eval "$(fnm env --multi)"
autoload -U add-zsh-hook
_fnm_autoload_hook () {
  if [[ -f .node-version && -r .node-version ]]; then
    echo "fnm: Found .node-version"
    fnm use
  elif [[ -f .nvmrc && -r .nvmrc ]]; then
    echo "fnm: Found .nvmrc"
    fnm use
  fi
}

add-zsh-hook chpwd _fnm_autoload_hook \
  && _fnm_autoload_hook

export YVM_DIR=/Users/lpender/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
