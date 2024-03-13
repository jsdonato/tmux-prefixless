#!/usr/bin/env bash
declare -r CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#set -e

# Map everything into a key table instead of root
keytable=prefixless

# ==============================================================================
# CLIENT
# ==============================================================================
tmux bind-key -T "$keytable" M-d detach-client
tmux bind-key -T "$keytable" M-c copy-mode
# ==============================================================================
# NAVIGATION
# ==============================================================================

# close current pane
tmux bind-key -T "$keytable" M-w kill-pane

# Choose a session
# tmux bind-key -T "$keytable" M-a choose-session -O name

# Switch to next/previous session with <M-S-j/k>
# tmux bind-key -T "$keytable" M-J switch-client -n
# tmux bind-key -T "$keytable" M-K switch-client -p

# Switch to next/previous window with <M-S-h/l>
tmux bind-key -T "$keytable" 'M-[' previous-window
tmux bind-key -T "$keytable" 'M-]' next-window

# Select Windows <M-#>
tmux bind-key -T "$keytable" M-1 select-window -t 1
tmux bind-key -T "$keytable" M-2 select-window -t 2
tmux bind-key -T "$keytable" M-3 select-window -t 3
tmux bind-key -T "$keytable" M-4 select-window -t 4
tmux bind-key -T "$keytable" M-5 select-window -t 5
tmux bind-key -T "$keytable" M-6 select-window -t 6
tmux bind-key -T "$keytable" M-7 select-window -t 7
tmux bind-key -T "$keytable" M-8 select-window -t 8
tmux bind-key -T "$keytable" M-9 select-window -t 9
tmux bind-key -T "$keytable" M-0 select-window -t 10

# Switch panes with <M-h/j/k/l>
tmux bind-key -T "$keytable" M-h select-pane -L
tmux bind-key -T "$keytable" M-l select-pane -R
tmux bind-key -T "$keytable" M-k select-pane -U
tmux bind-key -T "$keytable" M-j select-pane -D

# https://github.com/numToStr/Navigator.nvim/
# Switch panes in vim with <M-h/j/k/l>
# is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
# tmux bind-key -T "$keytable" M-h if-shell "$is_vim" 'send-keys M-h' 'select-pane -L'
# tmux bind-key -T "$keytable" M-j if-shell "$is_vim" 'send-keys M-j' 'select-pane -D'
# tmux bind-key -T "$keytable" M-k if-shell "$is_vim" 'send-keys M-k' 'select-pane -U'
# tmux bind-key -T "$keytable" M-l if-shell "$is_vim" 'send-keys M-l' 'select-pane -R'

# Toggle zoom
# tmux bind-key -T "$keytable" M-z resize-pane -Z

# ==============================================================================
# SESSION
# ==============================================================================

# Rename session with <M-R>
# tmux bind-key -T "$keytable" M-R command-prompt 'rename-session %%'

# New pane with <M-S/s/V/v>
tmux bind-key -T "$keytable" 'M--' "split-window -v -c '#{pane_current_path}'"
tmux bind-key -T "$keytable" 'M-\' "split-window -h -c '#{pane_current_path}'"

# Resize pane with <M-Arrow>
# tmux bind-key -T "$keytable" M-Left resize-pane -L
# tmux bind-key -T "$keytable" M-Right resize-pane -R
# tmux bind-key -T "$keytable" M-Up resize-pane -U
# tmux bind-key -T "$keytable" M-Down resize-pane -D

# Close pane using kill-pane.bash
# kill-pane.bash prevents killing panes if certain processes are running
# tmux bind-key -T "$keytable" M-x "run-shell $CURRENT_DIR/bin/kill-pane.bash"

# ==============================================================================
# WINDOWS
# ==============================================================================

# New/rename/swap window with <M-N/r/S-Left/S-Right>
tmux bind-key -T "$keytable" M-t "new-window -c '#{pane_current_path}'"
# tmux bind-key -T "$keytable" M-r "command-prompt 'rename-window %%'"

# # Synchronize panes on/off with with <M-Z/z>
# tmux bind-key -T "$keytable" M-b set-window-option synchronize-panes on
# tmux bind-key -T "$keytable" M-b set-window-option synchronize-panes off

# Make layout even with <M-=>
# tmux bind-key -T "$keytable" M-= select-layout -E

# ==============================================================================
# PANES
# ==============================================================================

# Copy pane directory <M-d>
# tmux bind-key -T "$keytable" M-d "run-shell -b $CURRENT_DIR/bin/copy-pane-path.bash"

# Mark pane
# tmux bind-key -T "$keytable" M-m select-pane -m

# ==============================================================================
# COPY-MODE-VI
# ==============================================================================
# tmux set-window-option -g mode-keys vi

# Enter copy mode
# tmux bind-key -T "$keytable" "M-[" copy-mode

# ==============================================================================
# MISC
# ==============================================================================

# Reload .tmux.conf
# tmux bind-key -T "$keytable" M-F5 source-file ~/.tmux.conf

# tmux bind-key -T "$keytable" M-: command-prompt

# ==============================================================================
# SET KEY-TABLE
# ==============================================================================
tmux set-option -gs key-table "$keytable"

# Enable/disable prefixless
tmux bind-key -T "root" M-o "set-option -gs key-table $keytable"
tmux bind-key -T "$keytable" M-i "set-option -gs key-table root"
