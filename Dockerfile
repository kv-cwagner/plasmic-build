# Base image (vscode user is preconfigured)
FROM mcr.microsoft.com/devcontainers/base:bullseye

# Switch to vscode user and use bash for RUN commands
USER vscode
SHELL ["/bin/bash", "-c"]

# Create workspace directory and set permissions
RUN sudo mkdir -p /workspaces && \
    sudo chown -R vscode:vscode /workspaces && \
    mkdir -p /workspaces/plasmic-build

# Install OS packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
        build-essential \
        python3 \
        python3-pip \
        virtualenvwrapper \
        postgresql-client \
        wget \
        direnv \
        screen \
        procps \
        curl \
        file \
        git \
        libffi-dev \
        libssl-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        liblzma-dev \
        libncurses-dev \
        tk-dev && \
    sudo rm -rf /var/lib/apt/lists/*

# Set non-interactive mode for installations
ENV NONINTERACTIVE=1

# Install Homebrew and asdf, add desired plugins, and configure the shell
RUN set -eux; \
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | NONINTERACTIVE=1 /bin/bash; \
    if [ -d "$HOME/.linuxbrew" ]; then \
      BREW_PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin"; \
    elif [ -d "/home/linuxbrew/.linuxbrew" ]; then \
      BREW_PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"; \
    else \
      echo "Homebrew installation not found"; exit 1; \
    fi; \
    echo "export BREW_PATH=${BREW_PATH}" >> ~/.bashrc; \
    echo "export PATH=${BREW_PATH}:\$PATH" >> ~/.bashrc; \
    export BREW_PATH=${BREW_PATH}; \
    export PATH=${BREW_PATH}:$PATH; \
    brew --version; \
    brew install asdf; \
    asdf plugin add nodejs; \
    asdf plugin add python; \
    asdf plugin add direnv; \
    echo ". ${BREW_PATH%/*}:/opt/asdf/libexec/asdf.sh" >> ~/.bashrc

# Set environment variables for Homebrew and asdf
ENV BREW_PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"
ENV PATH="/home/vscode/.asdf/shims:${BREW_PATH}:${PATH}"

# Copy project files with appropriate ownership
COPY --chown=vscode:vscode plasmic/ /workspaces/plasmic-build/plasmic/
COPY --chown=vscode:vscode build_scripts/ /workspaces/plasmic-build/build_scripts/
COPY --chown=vscode:vscode .devcontainer/ /workspaces/plasmic-build/.devcontainer/
COPY --chown=vscode:vscode .git/ /workspaces/plasmic-build/.git/

# Run project setup commands from the plasmic directory
WORKDIR /workspaces/plasmic-build/plasmic
RUN echo $PATH && \
    asdf install && \
    asdf reshim nodejs && \
    direnv allow && \
    pip3 install -r requirements-dev.txt && \
    corepack enable && \
    npm install -g nx && \
    asdf reshim nodejs && \
    (nx reset || true) && \
    yarn setup && \
    yarn bootstrap && \
    yarn setup:canvas-packages && \
    yarn make && \
    sed -i \
      -e 's|import { DEFAULT_DATABASE_URI } from "@/wab/server/config";|import { loadConfig } from "@/wab/server/config";|' \
      -e '/const con = await ensureDbConnection(DEFAULT_DATABASE_URI, "default");/c\
const config = loadConfig();\
const con = await ensureDbConnection(config.databaseUri, "default");' \
      /workspaces/plasmic-build/plasmic/platform/wab/src/wab/server/db/DbInit.ts

# Set final working directory
WORKDIR /workspaces/plasmic-build
