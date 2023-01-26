# Installation Instructions

1. Install Homebrew
2. `brew install pyenv`
3. Add pyenv to .zshrc:

```echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc```

4. Reload terminal and run `pyenv install 3.11.1` (or whatever later version)
5. `pyenv global 3.11.1`
6. `pip install ansible`
6. `ansible-playbook -K mac-workstation.yml`
