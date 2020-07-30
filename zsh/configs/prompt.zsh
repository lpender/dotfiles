# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}
shopify_store_info() {
  if [[ -f .current_store ]]; then
    current_store=$(cat .current_store)
  fi
  if [[ -n $current_store ]]; then
    echo " %{$fg_bold[red]%}$current_store%{$reset_color%}"
  fi
}
setopt promptsubst
PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info)$(shopify_store_info) %# '
