#!/usr/bin/env sh

if [ -d "$(dirname "$BASH_SOURCE")/scripts" ]; then
  for i in $(dirname "$BASH_SOURCE")/scripts/*.sh; do
    source "$i"
  done
fi

if [ -d "$(dirname "$BASH_SOURCE")/build-opts" ]; then
  for i in $(dirname "$BASH_SOURCE")/build-opts/*; do
    source "$i"
  done
fi

if [ -d "$(dirname "$BASH_SOURCE")/commands" ]; then
  for i in $(dirname "$BASH_SOURCE")/commands/*.sh; do
    source "$i"
  done
fi

if [ -d "$(dirname "$BASH_SOURCE")/aliases" ]; then
  for i in $(dirname "$BASH_SOURCE")/aliases/*.sh; do
    source "$i"
  done
fi

unset i
