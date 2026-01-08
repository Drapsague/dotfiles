#!/usr/bin/env bash

for f in * .*; do
  [ "$f" = "." ] || [ "$f" = ".." ] && continue
  [ "$f" = ".git" ] || [ "$f" = "install.sh" ] || [ "$f" = "README.md" ] || ln -sf "$PWD/$f" "$HOME/$f"
done

