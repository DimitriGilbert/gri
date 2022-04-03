#!/bin/bash
if [ -d "$HOME/.config/gri" ]; then
  source "$HOME/.config/gri/gri.conf"
else
  mkdir -p "$HOME/.config/gri"
  echo "GRI_CONFIG_GIT_SERVER=github.com\nGRI_CONFIG_OUTPUT=\$HOME" > "$HOME/.config/gri/gri.conf"
  touch "$HOME/.config/gri/installed"
fi

#
# ARG_POSITIONAL_SINGLE([user],[user or organization name])
# ARG_POSITIONAL_SINGLE([app],[app name])
# ARG_POSITIONAL_SINGLE([tag],[tag information])
# ARG_POSITIONAL_SINGLE([output],[output directory],[$([ -n "$GRI_CONFIG_OUTPUT" ]&&echo $GRI_CONFIG_OUTPUT||echo $HOME)])
# ARG_OPTIONAL_SINGLE([arch],[a],[target architecture],[])
# ARG_OPTIONAL_SINGLE([git-server],[g],[git server domain],[$([ -n "$GRI_CONFIG_GIT_SERVER" ]&&echo $GRI_CONFIG_GIT_SERVER||echo 'github.com')])
# ARG_OPTIONAL_BOOLEAN([secure], , [use ssl connection to git server], [on])
# ARG_OPTIONAL_BOOLEAN([extract], , [extract], [on])
# ARG_OPTIONAL_BOOLEAN([exec], , [add execution right], [on])
# ARG_OPTIONAL_BOOLEAN([source], , [download source])
# ARG_HELP([easily grab release from github])
# ARGBASH_GO

# [ <-- needed because of Argbash

grilog="$_arg_user $_arg_app $_arg_tag $_arg_output --git-server $_arg_git_server"

if [ -n "$_arg_arch" ]; then
  grilog="$grilog --arch $_arg_arch"
  _arg_arch="_$_arg_arch"
fi

GRI_PROTOCOL="http"
if [ "$_arg_secure" != "off" ]; then
  GRI_PROTOCOL="${GRI_PROTOCOL}s"
fi

if [ "$_arg_source" == "on" ]; then
  GRI_BASE_URL="${GRI_PROTOCOL}://${_arg_git_server}/${_arg_user}/${_arg_app}/archive/refs/tags/v${_arg_tag}.tar.gz"
  _arg_exec="off"
  grilog="$grilog --source"
else
  GRI_BASE_URL="${GRI_PROTOCOL}://${_arg_git_server}/${_arg_user}/${_arg_app}/releases/download/v${_arg_tag}/${_arg_app}_${_arg_tag}${_arg_arch}.tar.gz"
fi

GRI_TMP_FILE=$(mktemp)

if [ ! -d "${_arg_output}/${_arg_app}_${_arg_tag}" ]; then
  mkdir -p "${_arg_output}/${_arg_app}_${_arg_tag}"
fi

curl -LJ --output $GRI_TMP_FILE $GRI_BASE_URL

if [ "$_arg_extract" == "off" ]; then
  cp "$GRI_TMP_FILE" "${_arg_output}/${_arg_app}_${_arg_tag}${_arg_arch}.tar.gz"
else
  tar -xzf "$GRI_TMP_FILE" -C "${_arg_output}/${_arg_app}_${_arg_tag}"

  if [ "$_arg_exec" != "off" ]; then
    chmod +x "${_arg_output}/${_arg_app}_${_arg_tag}" -R
  fi
fi

rm $GRI_TMP_FILE

echo "$grilog" >> "$HOME/.config/gri/installed"

# ] <-- needed because of Argbash