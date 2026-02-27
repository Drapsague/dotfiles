#!/usr/bin/env bash
shopt -s nullglob

for f in * .*; do
  [ "$f" = "." ] || [ "$f" = ".." ] && continue
  [ "$f" = ".git" ] || [ "$f" = "install.sh" ] || [ "$f" = "README.md" ] && continue

  if [ "$f" = ".config" ]; then
    for c in .config/*; do
      ln -sf "$PWD/$c" "$HOME/.config/$(basename "$c")"
    done
  else
    ln -sf "$PWD/$f" "$HOME/$f"
  fi
done
