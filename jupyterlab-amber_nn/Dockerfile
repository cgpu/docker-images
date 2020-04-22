ARG BASE_CONTAINER=aaronhopkinson/n102-jupyterlab-base:latest
FROM $BASE_CONTAINER
MAINTAINER "Aaron Hopkinson"

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    # dependencies for Spektral
    graphviz libgraphviz-dev libcgraph6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

COPY environment.yml /home/$NB_USER/
RUN conda env create --quiet -f /home/$NB_USER/environment.yml && \
    conda clean --all -f -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    rm /home/$NB_USER/environment.yml && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# anything inside work is mounted to the host
COPY entry.sh /usr/local/bin/
WORKDIR /home/$NB_USER/work/
CMD ["entry.sh"]
