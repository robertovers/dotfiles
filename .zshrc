# path
export PATH="$HOME/.local/bin:$PATH"
# path end

# scripts
eval "$(starship init zsh)"
eval "$(devbox global shellenv)"
# scripts end

# aliases
alias nv="nvim"
alias lg="lazygit"
alias tm="tmuxp load ~/dotfiles/tmuxp/main.yaml"
alias python="python3"
# aliases end

# starship
export STARSHIP_CONFIG=~/starship.toml
# staship end

# pnpm
export PNPM_HOME="/Users/robbie.overs/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
# pyenv end

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm end

# ghcup
[ -f "/Users/robbie.overs/.ghcup/env" ] && . "/Users/robbie.overs/.ghcup/env" # ghcup-env
# ghcup end

# tmuxp
start() {
  local DEV_DIR="~/dev"

  # Check if a project name was provided as an argument.
  if [ -z "$1" ]; then
    echo "Usage: start <project-name>"
    echo "Example: start my-repo"
    return 1
  fi

  # Construct the full path to the target project directory.
  local project_name="$1"
  local target_dir=$(eval echo "$DEV_DIR/$project_name") # 'eval' handles the '~'

  # Check if the project directory actually exists.
  if [ ! -d "$target_dir" ]; then
    echo "Error: Directory not found at '$target_dir'"
    return 1
  fi

  export PROJECT_DIR="$target_dir"

  # Load 'editor.yaml', but override the session name to be the project's name.
  # The '-d' flag starts it detached (in the background).
  echo "Loading session for '$project_name' from 'editor.yaml'..."
  tmuxp load ~/tmuxp/editor.yaml -s "$project_name" -d

  unset PROJECT_DIR

  echo "$project_name started in the background."
}
# tmuxp end
