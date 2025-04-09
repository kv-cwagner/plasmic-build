# plasmic-build

## Overview

Welcome to the `plasmic-build` repository.  
Our team has grown very interested in the Plasmic Platform and its capabilities. However, we work primarily through Docker and VSCode Dev Containers, and noticed that Plasmic's Docker images are currently listed as unmaintained.

When bringing up services using the existing docs, we found the Docker-specific setup docs for running the platform could use more care. We also encountered some bugs and inconsistencies.

## Goals of this Repository

1. **Primary goal** — Get the Plasmic Platform running consistently in a development environment using VSCode Dev Containers. Once stable, we'll contribute upstream (if accepted).
2. **Secondary goal** — Provide a way for our team to build and run Docker images of the platform over time, while complying with the AGPL license.
3. **Tertiary goal** — Share a devcontainer environment purpose-built for working on the Plasmic Platform.

## Structure

- We use a **git submodule** to keep the upstream `plasmic` repo intact.
- We’ve included a `.devcontainer/` setup that, combined with VSCode + Docker, brings up the Plasmic Platform in a local dev environment via Docker Compose.
  - Includes a `devcontainer.json` and provisioning via `install_script.sh`
  - Provides a sample `.env` file used by the provisioning script
  - Adds a containerized Postgres instance

## Provisioning Instructions

Coming soon. We're working to automate as much of this process as possible.

## Immediate Roadmap

We have other priorities at the moment, but the following items are in progress to stabilize our current dev workflow:

- Add provisioning instructions
- Merge install script into Dockerfile to reduce build time and potentially support hosted images

## Contributions

We’re not accepting contributions to this repository at this time.

While we appreciate any interest, our team is currently focused on internal priorities. Long-term, we do intend to contribute improvements upstream and maintain this repo for our use case.

# plasmic-build

## Overview

Welcome to the `plasmic-build` repository.  
Our team has grown very interested in the Plasmic Platform and its capabilities. However, we work primarily through Docker and VSCode Dev Containers, and noticed that Plasmic's Docker images are currently listed as unmaintained.

When bringing up services using the existing docs, we found the Docker-specific setup docs for running the platform could use more care. We also encountered some bugs and inconsistencies.

## Goals of this Repository

1. **Primary goal** — Get the Plasmic Platform running consistently in a development environment using VSCode Dev Containers. Once stable, we'll contribute upstream (if accepted).
2. **Secondary goal** — Provide a way for our team to build and run Docker images of the platform over time, while complying with the AGPL license.
3. **Tertiary goal** — Share a devcontainer environment purpose-built for working on the Plasmic Platform.

## Structure

- We use a **git submodule** to keep the upstream `plasmic` repo intact.
- We’ve included a `.devcontainer/` setup that, combined with VSCode + Docker, brings up the Plasmic Platform in a local dev environment via Docker Compose.
  - Includes a `devcontainer.json` and provisioning via `install_script.sh`
  - Provides a sample `.env` file used by the provisioning script
  - Adds a containerized Postgres instance

## Provisioning Instructions

Coming soon. We're working to automate as much of this process as possible.

## Immediate Roadmap

We have other priorities at the moment, but the following items are in progress to stabilize our current dev workflow:

- Add provisioning instructions
- Merge install script into Dockerfile to reduce build time and potentially support hosted images

## Contributions

We’re not accepting contributions to this repository at this time.

While we appreciate any interest, our team is currently focused on internal priorities. Long-term, we do intend to contribute improvements upstream and maintain this repo for our use case.

## License

This repository is governed by the GNU Affero General Public License v3.0 (AGPL-3.0), inherited from the upstream Plasmic Studio license.

Per the terms of the AGPL, this repository includes a full copy of the license in [`LICENSE`](./LICENSE).  
You are free to use, modify, and distribute this project under the same license, provided that any modifications and access to networked versions of the software also comply with AGPL-3.0 requirements.
