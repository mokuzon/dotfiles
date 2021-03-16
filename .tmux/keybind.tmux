# all the regular tmux keys
unbind-key C-b
set-option -g prefix C-t
bind-key C-t send-prefix

setw -g mode-keys vi
bind-key v copy-mode \; display "Copy mode"
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'S-v' send-keys -X select-line
bind-key -T copy-mode-vi 'Escape' send -X clear-selection
bind-key -T copy-mode-vi 'C-[' send -X cancel
bind-key -T copy-mode-vi 'C-a' send -X start-of-line
bind-key -T copy-mode-vi 'C-e' send -X end-of-line
bind-key -T copy-mode-vi 'M-f' send -X next-word
bind-key -T copy-mode-vi 'M-b' send -X previous-word
bind-key -T copy-mode-vi 'C-u' send -X scroll-up
bind-key -T copy-mode-vi 'C-d' send -X scroll-down
unbind-key p
set-option -g @paste 'p'

bind-key c new-window -c "#{pane_current_path}"
bind-key % split-window -hc "#{pane_current_path}"
bind-key '"' split-window -vc "#{pane_current_path}"
bind-key ( switch-client -p
bind-key ) switch-client -n
bind-key D choose-client
bind-key L switch-client -l
bind-key [ previous-window
bind-key ] next-window
bind-key c new-window
bind-key d detach-client
bind-key s choose-session
bind-key w choose-window
bind-key x confirm-before -p "kill-pane #P? (y/n)" kill-pane
bind-key r source-file ~/.tmux.conf\; display-message "Reload Config!!"
bind-key -n C-o select-pane -t :.+

