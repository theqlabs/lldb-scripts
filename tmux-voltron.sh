#! /bin/bash
SESSION=$USER

tmux -f ~/.tmux.config -2 new-session -d -s $SESSION; 

# Create Window
tmux new-window -t $SESSION:1 -n "lldb";

# Configure Voltron Panes
#tmux split-window -v	# 0 should be the lldb interpreter pane
#tmux select-pane -t 1	# 
#tmux resize-pane -U 40  # creating the small lldb>> at the top
#tmux split-window -h	# 
#tmux select-pane -t 2	# 
#tmux split-window -v 	# 
#tmux select-pane -t 2	#
#tmux split-window -h	# 
#tmux resize-pane -R 90	# resizing register view
#tmux select-pane -t 2	#
#tmux split-window -v	# should create breakpoint / backtrace 

tmux split-window -h
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -t 1
tmux resize-pane -D 10
tmux select-pane -t 2
tmux split-window -v
tmux select-pane -t 3
tmux resize-pane -D 10
tmux split-window -h
tmux select-pane -t 4
tmux resize-pane -R 28

# Window Pane IDs
# 0 - lldb>>
# 1 - disassembly
# 2 - breakpoints
#	3 - backtrace
#	4 - registers
#	5 - stack

# Setup commands
#tmux select-pane -t 1						
#tmux send-keys "voltron view disasm" C-m
#tmux select-pane -t 2
#tmux send-keys "voltron view breakpoints" C-m
#tmux select-pane -t 3
#tmux send-keys "voltron view backtrace" C-m
#tmux select-pane -t 4
#tmux send-keys "voltron view register" C-m
#tmux select-pane -t 5
#tmux send-keys "voltron view stack" C-m

#tmux select-pane -t 0	# allows user to input "lldb <binary>"

tmux select-pane -t 0
tmux send-keys "voltron view disasm" C-m
tmux select-pane -t 2
tmux send-keys "voltron view stack" C-m
tmux select-pane -t 3
tmux send-keys "voltron view backtrace" C-m
tmux select-pane -t 4
tmux send-keys "voltron view register" C-m

tmux select-pane -t 1	# allows user to input lldb <bin>


#HEIGHT=$(($(tmux display-message -p '#{pane_height}') / 5))
#tmux resize-pane -y $HEIGHT

# Attach to session
tmux -2 attach-session -t $SESSION
