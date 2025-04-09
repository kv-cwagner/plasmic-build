#!/bin/bash

sudo apt update
sudo apt install -y build-essential python3 python3-pip virtualenvwrapper postgresql-client wget direnv screen procps curl file git libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev libncurses-dev tk-dev

export NONINTERACTIVE=1

# Install Homebrew and set up environment
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

# Install asdf and add plugins
brew install asdf
asdf plugin add nodejs
asdf plugin add python
asdf plugin add direnv
echo ". /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh" >> ~/.bashrc

# Reload shell to update PATH with asdf shims
source ~/.bashrc
source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh

# Navigate to project and set up Git
cd /workspaces/plasmic-build/plasmic/
git config --global --add safe.directory /workspaces/plasmic-build/plasmic
git submodule update --init --recursive
git config submodule.recurse true

# Install Node.js and other tools via asdf
asdf install
# Refresh shims to ensure corepack is available
asdf reshim nodejs

# Allow direnv and install Python requirements
direnv allow
pip3 install -r requirements-dev.txt

# Ensure path is properly setup
export PATH="/home/vscode/.asdf/shims:$PATH"

# Enable corepack (now that the Node version should be updated and in PATH)
corepack enable

npm install -g nx
asdf reshim nodejs
nx reset

# The below line is necessary for now. It adds necessary packages to be installed properly. Eventually the goal should be to submit a package to update bootstrap.bash 
sed -i 's/\(for package in packages\/loader-angular packages\/react-web-runtime platform\/host-test\);/\1 platform\/loader-html-hydrate platform\/react-web-bundle platform\/live-frame platform\/canvas-packages platform\/sub platform\/wab;/' scripts/bootstrap.sh
yarn bootstrap
yarn make
# The below reverts the boostrap.sh to it's origina value to avoid a git differentce. Eventually the goal should be to submit a package to update bootstrap.bash 
sed -i 's/\(for package in packages\/loader-angular packages\/react-web-runtime platform\/host-test\) platform\/loader-html-hydrate platform\/react-web-bundle platform\/live-frame platform\/canvas-packages platform\/sub platform\/wab;/\1;/' scripts/bootstrap.sh
sed -i \
  -e 's|import { DEFAULT_DATABASE_URI } from "@/wab/server/config";|import { loadConfig } from "@/wab/server/config";|' \
  -e '/const con = await ensureDbConnection(DEFAULT_DATABASE_URI, "default");/c\
  const config = loadConfig();\
  const con = await ensureDbConnection(config.databaseUri, "default");' /workspaces/plasmic-build/plasmic/platform/wab/src/wab/server/db/DbInit.ts
cp /workspaces/plasmic-build/.devcontainer/.env.example.development /workspaces/plasmic-build/plasmic/platform/wab/.env
cd /workspaces/plasmic-build/
