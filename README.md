# plasmic-build

## Overview

Welcome to the plasmic-build repository.  
Our team has grown very interested in the Plasmic Platform and its capabilities. However, we work primarily through Docker and VSCode Dev Containers, and noticed that Plasmic's Docker images are currently listed as unmaintained.

When bringing up services using the existing docs, we found the Docker-specific setup docs for running the platform could use more care. We also encountered some bugs and inconsistencies.

## Goals of this Repository

1. **Primary goal** — Get the Plasmic Platform running consistently in a development environment using VSCode Dev Containers. Once stable, we'll contribute upstream (if accepted).
2. **Secondary goal** — Provide a way for our team to build and run Docker images of the platform over time, while complying with the AGPL license.
3. **Tertiary goal** — Share a devcontainer environment purpose-built for working on the Plasmic Platform.

## Structure

- We use a **git submodule** to keep the upstream plasmic repo intact.
- We’ve included a .devcontainer/ setup that, combined with VSCode + Docker, brings up the Plasmic Platform in a local dev environment via Docker Compose.
  - Includes a devcontainer.json and provisioning via install_script.sh
  - Provides a sample .env file used by the provisioning script
  - Adds a containerized Postgres instance
- There's also a standalone Dockerfile at the root, intended for running the platform *as a user* (i.e., building a Plasmic-based app, not modifying the platform).

## Provisioning Instructions

### For Devcontainer-based Platform Development

1. Open the repo in VSCode with Dev Containers support.
2. The devcontainer will auto-run install_script.sh to provision the environment.
3. Once the container is up:

   ```bash
   cd build_scripts
   ./plasmic_platform_initialization.sh
   ```

4. Then run:

   ```bash
   yarn dev
   ```

This will start the platform.

Everything should be fully functional after these steps.

## Usage Modes

We currently support two primary usage modes:

### 1. Platform Development via Dev Container

Use the .devcontainer folder and VSCode to boot into an environment that’s tailored for hacking on the Plasmic Platform itself. This uses install_script.sh and provides full access to build scripts and dependencies.

### 2. App Development via Root Dockerfile

If you're using the Plasmic Platform but not modifying it, build from the Dockerfile at the root of the repo. This replicates the install_script.sh steps but bakes them into a container image suitable for app development and deployment.

We'll be publishing a prebuilt image based on this flow soon, along with usage instructions.

Note: As of now, the Dockerfile only functions properly within the devcontainer setup. This is likely due to dependencies and structure specific to the Plasmic monorepo. We plan to investigate a standalone fix in the future.

## Docker Image Publishing

- We now are pushing Docker images of the Plasmic platform with the intention that it can be used alongside Plasmic.
- These builds are currently manual but in the future we hope to automate this process via GitHub workflows.
- We also intend to optimize these images significantly in terms of size and complexity.
- We plan to provide instructions and/or examples (for the time being) that support a devcontainer environment in a near future update.
- Production instructions will be out of scope for the foreseeable future in this repository.

## Roadmap

We have other priorities at the moment, but the following items are in progress to stabilize our current dev workflow:

- Examples for App Development Via the Root Dockerfile
- Optimize the root Dockerfile
- Continue to improve and consolidate provisioning
- Open upstream PRs once internal use is stable

## Contributions

We’re not accepting contributions to this repository at this time.

While we appreciate any interest, our team is currently focused on internal priorities. Long-term, we do intend to contribute improvements upstream and maintain this repo for our use case.

## License

This repository is governed by the GNU Affero General Public License v3.0 (AGPL-3.0), inherited from the upstream Plasmic Studio license.

Per the terms of the AGPL, this repository includes a full copy of the license in [LICENSE](./LICENSE).  
You are free to use, modify, and distribute this project under the same license, provided that any modifications and access to networked versions of the software also comply with AGPL-3.0 requirements.