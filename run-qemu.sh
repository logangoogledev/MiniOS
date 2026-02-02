#!/usr/bin/env bash
set -e

usage() {
  echo "Usage: $0 [--ephemeral]"
  echo "  --ephemeral   build in /tmp and remove artifacts after QEMU exits"
  exit 1
}

if [ "$1" = "--ephemeral" ]; then
  tmpdir=$(mktemp -d /tmp/minios-XXXX)
  echo "Building into $tmpdir"
  nasm -f bin boot/boot.asm -o "$tmpdir/boot.img"
  qemu-system-x86_64 -fda "$tmpdir/boot.img" -boot a -m 64M
  rm -rf "$tmpdir"
else
  make run
fi
