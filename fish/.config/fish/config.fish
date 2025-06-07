# ░█▀█░█▀█░▀█▀░█░█
# ░█▀▀░█▀█░░█░░█▀█
# ░▀░░░▀░▀░░▀░░▀░▀

# General path
# fish_config theme choose "Dracula Official"
set -x PATH /opt/homebrew/bin $PATH
set -x MANPATH /opt/homebrew/share/man $MANPATH
set -x INFOPATH /opt/homebrew/share/info $INFOPATH
set -x JAVA_HOME $HOME/.local/share/mise/installs/java/21.0.2
set -x PATH $JAVA_HOME/bin $PATH
set -x PATH $HOME/.pub-cache/bin $PATH
set -x PATH $PATH $HOME/development/android_sdk/cmdline-tools/latest/bin
set -x PATH $PATH $HOME/development/android_sdk/platform-tools
set -x PATH $PATH $HOME/development/android_sdk/emulator
set -x ANDROID_HOME $HOME/development/android_sdk



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
alias wuwaon 'displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1440x900 scaling:off"'
alias wuwaoff 'displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1440x900 scaling:on"'

#config alias
alias cfish 'nvim ~/.config/fish/config.fish'
alias sfish 'source ~/.config/fish/config.fish'
alias pfish 'nvim ~/.config/fish/functions/fish_prompt.fish'
alias czsh 'nvim ~/.zshrc'
alias cbash 'nvim ~/.bashrc'
alias cmux 'nvim .tmux.conf'
alias cghost 'nvim ~/.config/ghostty/config'
alias smux 'tmux source ~/.tmux.conf'
alias cnv 'nvim ~/.config/nvim/'
alias cstar 'nvim ~/.config/starship.toml'
alias cneo 'nvim ~/.config/neofetch/config.conf'
alias cyab 'nvim ~/.config/yabai/yabairc'
alias cskhd 'nvim ~/.config/skhd/skhdrc'
alias cl 'clear && clear'

#tmux alias
alias tns 'tmux new -s'
alias tks 'tmux kill-server'
alias tach 'tmux attach'

#git alias
alias gc 'git checkout'
alias glb 'git branch -a'
alias gcl 'git clone'

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

alias brewupdate='brew update && brew upgrade && brew cleanup'


# ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
# ░█░░░█░█░█░█░█▀▀░░█░░█░█
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

# Set history limit to 5000 entries
set -U fish_history_limit 5000

# FZF config



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







test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

