sudo apt update
sudo apt install -y build-essential python3 python3-pip virtualenvwrapper postgresql-client wget direnv screen procps curl file git libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev libncurses-dev tk-dev # dos2unix pre-commit rollup
export NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
brew install asdf
asdf plugin add nodejs
asdf plugin add python
asdf plugin add direnv
echo ". /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh" >> ~/.zshrc
asdf install
direnv allow
zsh
omz reload
git config --global --add safe.directory /workspaces/plasmic
pip3 install -r requirements-dev.txt # remove if above starts working
git submodule update --init --recursive
git config submodule.recurse true
corepack enable
asdf reshim nodejs
# The below line is necessary for now. Eventually the goal should be to submit a package to update bootstrap.bash 
sed -i 's/\(for package in packages\/loader-angular packages\/react-web-runtime platform\/host-test\);/\1 platform\/loader-html-hydrate platform\/react-web-bundle platform\/live-frame platform\/canvas-packages platform\/sub platform\/wab;/' scripts/bootstrap.sh
yarn bootstrap
