ARG BASE_CONTAINER=jupyter/minimal-notebook:dc9744740e12
FROM $BASE_CONTAINER
MAINTAINER "Aaron Hopkinson"

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install --quiet --yes \
    # diffing notebooks
    nbdime \
    # git integration (broken at the moment)
#    jupyterlab-git \
    # auto code formatting
    jupyterlab_code_formatter \
    isort \
    black \
    nodejs \
    # custom conda environments
    nb_conda_kernels \
    # automatically pulling notebook from git
    nbgitpuller \
    && \
    # activate all the jupyter extensions
    jupyter labextension install \
    @jupyterlab/toc \
    @aquirdturtle/collapsible_headings \
    @ijmbarr/jupyterlab_spellchecker \
    @krassowski/jupyterlab_go_to_definition \
    @ryantam626/jupyterlab_code_formatter && \
    jupyter serverextension enable --py --sys-prefix jupyterlab_code_formatter && \
    echo "envs_dirs:\n  - /home/$NB_USER/conda-envs/" > /home/$NB_USER/.condarc && \
    sed -i 's/  }/  },\n  "CondaKernelSpecManager": {\n    "env_filter": "\/opt\/conda\/*",\n    "name_format": "{0} ({1})"\n  }/' /opt/conda/etc/jupyter/jupyter_notebook_config.json && \
    # clean up
    conda clean --all -f -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV JUPYTER_ENABLE_LAB=yes
