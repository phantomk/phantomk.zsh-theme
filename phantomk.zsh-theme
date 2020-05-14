# phantomk theme
# based on ys

# VCS
PK_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
PK_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
PK_VCS_PROMPT_SUFFIX="%{$reset_color%}"
PK_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
PK_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# nvm info
local nvm_info='$(nvm_prompt_info)'
ZSH_THEME_NVM_PROMPT_PREFIX=" node:"
ZSH_THEME_NVM_PROMPT_SUFFIX=""

# gvm info
local gvm_info='$(gvm_prompt_info)'
ZSH_THEME_GVM_PROMPT_PREFIX=" go:"
ZSH_THEME_GVM_PROMPT_SUFFIX=""

gvm_prompt_info() {
  local gvm_prompt
  gvm_prompt=$(go version 2>/dev/null)
  [[ "${gvm_prompt}x" == "x" ]] && return
  gvm_prompt=${${gvm_prompt:13}% *}
  echo "${ZSH_THEME_GVM_PROMPT_PREFIX}${gvm_prompt}${ZSH_THEME_GVM_PROMPT_SUFFIX}"
}

# dvm info
local dvm_info='$(dvm_prompt_info)'
ZSH_THEME_DVM_PROMPT_PREFIX=" deno:"
ZSH_THEME_DVM_PROMPT_SUFFIX=""

dvm_prompt_info() {
  local dvm_prompt
  dvm_prompt=$(deno -V 2>/dev/null)
  [[ "${dvm_prompt}x" == "x" ]] && return
  dvm_prompt=${${dvm_prompt:5}% *}
  echo "${ZSH_THEME_DVM_PROMPT_PREFIX}${dvm_prompt}${ZSH_THEME_DVM_PROMPT_SUFFIX}"
}

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="$PK_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$PK_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(PK_hg_prompt_info)'
PK_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${PK_VCS_PROMPT_PREFIX1}hg${PK_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$PK_VCS_PROMPT_DIRTY"
		else
			echo -n "$PK_VCS_PROMPT_CLEAN"
		fi
		echo -n "$PK_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"


# iterm2 下只支持 iterm2 的 主题color，无效的为 iterm 主题默认
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
%{$fg[green]%}${nvm_info}%{$reset_color%}\
%{$fg[white]%}${dvm_info}%{$reset_color%}\
%{$fg[cyan]%}${gvm_info}%{$reset_color%}\
%{$fg[blue]%}${git_info}%{$reset_color%}\
 \
%{$fg[blue]%}[%*] $exit_code
%{$terminfo[bold]$fg[green]%}$ %{$reset_color%}"
