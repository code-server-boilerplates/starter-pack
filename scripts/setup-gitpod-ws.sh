#!/bin/bash

### NOTE TO TEMPLATE MAINTAINERS - START ###
# If you ever update Gitpod configuration file (.gitpod.yml) for your own
# starters, you should also update this script!
### NOTE TO TEMPLATE MAINTAINERS - END ###

if [[ $GITPOD != "1" && $GITPOD_WORKSPACE_URL == "" ]]; then
  echo "You're not inside an Gitpod workspace, exiting..."
  exit 1
fi

GITPOD_WORKSPACE_DIR="/workspace/csb"
REPO_ROOT=${GITPOD_REPO_ROOT:-"$GITPOD_WORKSPACE_DIR/starter-pack"}

# We setup GitLab.com mirrors, just in case you opened this repo in Gitpod from GitLab.
# If you're an template/starter maintainer and don't mirror stuff on GitLab.com (also called
# GitLab SaaS), you probably remove this if-then-else statement below and hardcode
# REPO_URL_PREFIX into your GitHub repo namespace instead.
if [[ $GITPOD_WORKSPACE_CONTEXT_URL == "https://gitlab.com/"* ]]; then
  REPO_URL_PREFIX="https://gitlab.com/code-server-boilerplates"
else
  REPO_URL_PREFIX="https://github.com/code-server-boilerplates"
fi

# Just in case you ran this script directly owo.
if [ ! -d "$GITPOD_WORKSPACE_DIR" ]; then
  sudo mkdir -p $GITPOD_WORKSPACE_DIR
  chown -Rv "$(id -ru)":"$(id -ru)" /workspace
fi

# Main starter pack repo
if [ ! -d "$GITPOD_WORKSPACE_DIR/starter-pack" ]; then
    git clone $REPO_URL_PREFIX/starter-pack /workspace/csb/starter-pack
elif [ -d "$GITPOD_WORKSPACE_DIR/starter-pack" ] && [[ $PWD == "$REPO_ROOT" ]]; then
    # Don't pull, unless the user manually pulled stuff
    git fetch --all
else
    git -C "$GITPOD_WORKSPACE_DIR/starter-pack" fetch --all
    git -C "$GITPOD_WORKSPACE_DIR/starter-pack" pull origin
fi

# Cloud-native Starter / Starter Pack-as-Base Image
if [ ! -d "$GITPOD_WORKSPACE_DIR/cloud-native-dev-starter" ]; then
    git clone $REPO_URL_PREFIX/starter-pack-as-base-image /workspace/csb/cloud-native-dev-starter
elif [ -d "$GITPOD_WORKSPACE_DIR/cloud-native-dev-starter" ] && [[ $PWD == "$REPO_ROOT" ]]; then
    # Don't pull, unless the user manually pulled stuff
    git fetch --all
else
    git -C "$GITPOD_WORKSPACE_DIR/cloud-native-dev-starter" fetch --all
    git -C "$GITPOD_WORKSPACE_DIR/cloud-native-dev-starter" pull origin
fi

# Node.js starter
if [ ! -d "$GITPOD_WORKSPACE_DIR/nodejs-starter" ]; then
    git clone $REPO_URL_PREFIX/nodejs-starter /workspace/csb/nodejs-starter
elif [ -d "$GITPOD_WORKSPACE_DIR/nodejs-starter" ] && [[ $PWD == "$REPO_ROOT" ]]; then
    # Don't pull, unless the user manually pulled stuff
    git fetch --all
else
    git -C "/workspace/csb/nodejs-starter" fetch --all
    git -C "/workspace/csb/nodejs-starter" pull origin
fi

# Helm Charts repo, maybe moving to GitLab's built-in Helm Charts registry soon OwO
if [ ! -d "/workspace/csb/charts" ]; then
    git clone $REPO_URL_PREFIX/charts /workspace/csb/charts
elif [ -d "$GITPOD_WORKSPACE_DIR/cloud-native-dev-starter" ] && [[ $PWD == "$REPO_ROOT" ]]; then
    # Don't pull, unless the user manually pulled stuff
    git fetch --all
else
    git -C "/workspace/csb/charts" fetch --all
    git -C "/workspace/csb/charts" pull origin
fi