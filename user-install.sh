#!/bin/bash
mkdir -p $HOME/.local/share/terminal-psi
cp -r psi-attacks $HOME/.local/share/terminal-psi
cp -r jeffs-gadgets $HOME/.local/share/terminal-psi
cp bin/pk $HOME/.local/bin
echo "PSi effects installed for user $(whoami), make sure '~/.local/bin' is on your PATH."
