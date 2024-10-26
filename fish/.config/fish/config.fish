# ░█▀█░█▀█░▀█▀░█░█
# ░█▀▀░█▀█░░█░░█▀█
# ░▀░░░▀░▀░░▀░░▀░▀

# General path
set -x PATH /opt/homebrew/bin $PATH
set -x MANPATH /opt/homebrew/share/man $MANPATH
set -x INFOPATH /opt/homebrew/share/info $INFOPATH
set -x PATH $HOME/development/flutter/bin $PATH
set -x JAVA_HOME /Users/muhammadpadanta/.local/share/mise/installs/java/21.0.2
set -x PATH $JAVA_HOME/bin $PATH
set -x PATH $HOME/.pub-cache/bin $PATH


# ░█▀█░█░░░▀█▀░█▀█░█▀▀░█▀▀░█▀▀
# ░█▀█░█░░░░█░░█▀█░▀▀█░█▀▀░▀▀█
# ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀

# general aliases
alias stopxampp 'sudo /opt/lampp/xampp stop'
alias startxampp 'sudo /opt/lampp/xampp start'
alias mysqlxampp 'sudo /opt/lampp/bin/mysql -u root -p'
alias obs 'flatpak run com.obsproject.Studioo'
alias cx 'chmod +x'
alias icat 'kitten icat' 
alias startssh 'sudo systemctl start ssh'
alias statusssh 'sudo systemctl status ssh'
alias stopssh 'sudo systemctl stop ssh'
alias gemini 'python ~/project/python/gemini.py'
alias hapus 'rm -rf'
alias shapus 'sudo rm -rf'

#config alias
alias cfish 'nvim ~/.config/fish/config.fish'
alias sfish 'source ~/.config/fish/config.fish'
alias pfish 'nvim ~/.config/fish/functions/fish_prompt.fish'
alias czsh 'nvim ~/.zshrc'
alias cbash 'nvim ~/.bashrc'
alias cmux 'nvim .tmux.conf'
alias smux 'tmux source ~/.tmux.conf'
alias cnv 'nvim ~/.config/nvim/'
alias cstar 'nvim ~/.config/starship.toml'
alias cneo 'nvim ~/.config/neofetch/config.conf'
alias cl 'clear'

#tmux alias
alias tns 'tmux new -s'
alias tks 'tmux kill-server'
alias tach 'tmux attach'

#git alias
alias gc 'git checkout'
alias glb 'git branch -a'

#AVD alias
alias listavd '$ANDROID_HOME/tools/emulator -list-avds'
alias startavd '$ANDROID_HOME/tools/emulator -avd Pixel_7_API_35'

# browser alias
alias chrome 'google-chrome --new-tab 2>/dev/null'
alias firefox 'firefox --new-tab 2>/dev/null'
alias brave 'brave-browser --new-tab 2>/dev/null'

# du aliases
# check the size of a directory
alias dsize='du -sh'
# check the size of all directories and subdirectories in the current path
alias dsize-all='du -sh * | sort -rh'

# exa aliases
alias ls='eza -F --icons'
alias ll='eza -l --icons'
alias la='eza -a -F --icons'
alias lt='eza -T --icons'
alias lta='eza -T -a -L4 --ignore-glob=.git --icons'


# ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
# ░█░░░█░█░█░█░█▀▀░░█░░█░█
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

# Set history limit to 5000 entries
set -U fish_history_limit 5000

# FZF config
set -Ux FZF_DEFAULT_OPTS \
  "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
   --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
   --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
   --color 'border:#ffffff,info:#ffff00' \
   --preview 'seq 1000' \
   --height 70% --border --layout reverse"

fzf_configure_bindings --directory=\cf


# ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█
# ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█
# ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀


# fish function to cd to parent directory
function cd
    switch (count $argv)
        case 1
            switch $argv[1]
                case "..."
                    builtin cd ../..
                case "...."
                    builtin cd ../../..
                case "....."
                    builtin cd ../../../..
                # Add more cases if needed
                case "*"
                    builtin cd $argv
            end
        case "*"
            builtin cd $argv
    end
end

set -U fish_greeting



# ░▀█▀░█▀█░▀█▀░▀█▀░▀█▀░█▀█░█░░░▀█▀░▀▀█░█▀▀
# ░░█░░█░█░░█░░░█░░░█░░█▀█░█░░░░█░░▄▀░░█▀▀
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀

starship init fish | source
zoxide init fish | source
~/.local/bin/mise activate fish | source







test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
