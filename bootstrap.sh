#!/usr/bin/env bash -e
#
# Sets up requirements to provision with ansible
#
PYTHON_VERSION="2.7.14"

#
# Clean display function
#
# usage:
#        display "My thing to output"
#
function display() {
    echo "----> $1"
}

if $(xcode-select --install 1>/dev/null 2>&1);
then
  exit 1
fi

if [ ! $(which brew) ]
then
    display "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ ! -f '/usr/local/bin/git' ]
then
  display "Installing git"
  brew install git
fi

if [ ! -d "$HOME/.pyenv" ];
then
    display "Installing pyenv"
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ ! -d "$PYENV_ROOT/versions/$PYTHON_VERSION" ];
then
  display "Installing Python $PYTHON_VERSION"
  pyenv install $PYTHON_VERSION
fi

if ! grep -q "$PYTHON_VERSION" $HOME/.pyenv/version;
then
  display "Setting pyenv Python globally to $PYTHON_VERSION"
  pyenv global $PYTHON_VERSION
fi

display "Installing Ansible"
pip install --upgrade ansible boto

if [ ! -d "$HOME/git/macbook-bootstrap" ];
then
  git clone https://github.com/dude051/macbook-bootstrap.git ${HOME}/git/macbook-bootstrap
fi

# vim: ft=sh:
