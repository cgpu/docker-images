#!/bin/bash

git config --global user.name "${NAME:-}"
git config --global user.email "${EMAIL:-}"

conda init &> /dev/null

# enable nbdime git integration
nbdime config-git --enable --global

# pull main repo into home space
if [[ -n ${GITHUB_TOKEN:-} ]]; then
  #git config --global url.”https://${GITHUB_TOKEN}:@github.com/".insteadOf “https://github.com/"
  gitpuller https://${GITHUB_TOKEN}:@github.com/arh89/amber_nn.git master ~/work/amber_nn-MASTER
fi

# start the notebook (CMD in jupyter/base-notebook)
. /usr/local/bin/start-notebook.sh
