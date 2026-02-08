#!/usr/bin/env bash
# 用 --- 作为多行条目的分隔符

awk '
  BEGIN { RS="---\n"; ORS="\0" }
  NF { sub(/\n$/, ""); print }
' "$HOME/.config/tmux/scripts/quick-commands/quick-commands.txt" \
| fzf --read0 --reverse --border=none --prompt="Copy > " \
| tmux load-buffer -w -
