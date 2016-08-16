#! /bin/bash
SESSION=$USER

tmux -f ~/.tmux.config -2 new-session -d -s $SESSION; 

# Create Window
tmux new-window -t $SESSION:1 -n "lldb";

tmux split-window -v
tmux select-pane -t 1
tmux resize-pane -D 10
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h
tmux split-window -h
tmux select-pane -t 3
tmux resize-pane -L 30
tmux select-pane -t 2
tmux resize-pane -L 80
tmux select-pane -t 4
tmux resize-pane -R 60
tmux select-pane -t 2
tmux split-window -v

# Window Pane IDs
# 0 - disassembly
# 1 - stack
# 2 - breakpoints
#	3 - backtrace
#	4 - lldb>>
#	5 - registers

tmux select-pane -t 0
tmux send-keys "voltron view disasm" C-m
tmux select-pane -t 1
tmux send-keys "voltron view stack" C-m
tmux select-pane -t 2
tmux send-keys "voltron view breakpoints" C-m
tmux select-pane -t 3
tmux send-keys "voltron view backtrace" C-m
tmux select-pane -t 5
tmux send-keys "voltron view register" C-m

tmux select-pane -t 4	# allows user to input lldb <bin>

#HEIGHT=$(($(tmux display-message -p '#{pane_height}') / 5))
#tmux resize-pane -y $HEIGHT

# Attach to session
tmux -2 attach-session -t $SESSION
