#!/bin/bash

# 環境情報の収集と表示

echo "=== System Information ==="
echo "User: $(whoami)"
echo "Shell: $SHELL"
echo "Terminal: $TERM"
echo "Locale:"
locale
echo

echo "=== Checking tmux ==="
if [ -n "$TMUX" ]; then
    echo "tmux is running."
    echo "Current tmux session info:"
    tmux list-sessions
    echo
    echo "tmux environment variable TERM: $TERM"
else
    echo "tmux is not running."
fi
echo

echo "=== Checking Neovim Configuration ==="
if command -v nvim > /dev/null 2>&1; then
    echo "Neovim is installed."
    echo "Neovim version:"
    nvim --version | head -n 1
else
    echo "Neovim is not installed."
fi
echo

echo "=== Key Input Test ==="
echo "Testing Ctrl keys with 'showkey' (if available)..."
if command -v showkey > /dev/null 2>&1; then
    echo "Please press Ctrl+h and Ctrl+l after running the command below."
    echo "Press Ctrl+C to exit."
    echo "Running: sudo showkey -a"
    sudo showkey -a
else
    echo "showkey is not installed. Skipping key input test."
fi
echo

echo "=== Checking tmux Key Bindings ==="
if [ -f ~/.tmux.conf ]; then
    echo "~/.tmux.conf exists. Checking for Ctrl key bindings..."
    grep -E "bind.*C-[hl]" ~/.tmux.conf
else
    echo "~/.tmux.conf not found."
fi
echo

echo "=== Checking Terminal Settings ==="
echo "cat input test: Press Ctrl+h and Ctrl+l, then Ctrl+D to exit."
cat
echo

echo "=== Suggestions ==="
echo "1. Check your terminal emulator settings (e.g., iTerm2, Alacritty)."
echo "2. Ensure TERM is set to 'screen-256color' in tmux."
echo "3. Verify key mappings in tmux and Neovim."
echo

echo "Done!"

