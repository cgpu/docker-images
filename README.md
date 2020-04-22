# docker-images

- `jupyterlab-base`:
  - Builds on top of [jupyter/minimal-notebook](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook)
    adding a small number of extensions to the base JupyterLab environment.

- `jupyterlab-amber_nn`:
  - Pulls in a custom conda environment and automatically clones the latest
    version of the code/notebook repository down to the home space.

Setup (to run the JupyterLab environment):
  **You only need to do these steps once**
  1. Install Docker
  2. Create a [GitHub Personal Access Token](https://github.com/settings/token) granting access to your repositories.
  3. Create a plain text file called `secrets` in the same directory as `start_container.sh` with the content
     `GITHUB_TOKEN=<token>`. **Do not give out your access token! Treat secrets as if it were your ssh keys!**
  4. Ensure permissions are set so this is only readable by your own user account.

  NB: Docker might be configured to use only a limited amount of CPU/memory - you might wish to increase this.

To run:
  * Launch `start_container.sh` and open the webpage starting with `127.0.0.1` (including the access token)
  * This will automatically mount to a local volume called `mount` in the present working directory from which you launch the script.
    This directory will mirror the working directory (`~/work`) in the JupyterLab instance.

  * **Note: Anything not stored under `~/work` will be lost when closing the Docker container**
