#!/bin/bash

START_DIR="${START_DIR:-/home/coder/project}"

PREFIX=${TEMPLATE_SLUG_PREFIX}

mkdir -p $START_DIR

useDefaultConfig() {
       git config  --global user.name "Recap Time Bot"
       git config --global user.email "service-accounts@madebythepins.tk"
}


if [[ $GIT_USER_EMAIL == "" ]] && [[ $GIT_USER_NAME == "" ]]; then
  echo "[$PREFIX] No email address and name found for configuring Git. Git will prompt you to configure them"
  echo "[$PREFIX] before ever commiting something. Falling back to defaults using github:RecapTimeBot user info..."
  useDefaultConfig
elif [[ $GIT_USER_EMAIL == "" ]]; then
  echo "[$PREFIX] Git user email found, but name isn't found. Using defaults based on"
  echo "[$PREFIX] github:RecapTimeBot user info..."
  useDefaultConfig
elif [[ $GIT_USER_NAME == "" ]]; then
  echo "[$PREFIX] Git user name found, but email isn't found. Using defaults based on"
  echo "[$PREFIX] github:RecapTimeBot user info..."
  useDefaultConfig
else
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
fi

# handle auth token saving to gitconfig stuff here
### GITHUB / GHE ###
if [[ $GITHUB_TOKEN != "" ]]; then
  echo "[$PREFIX] Setting up auth for GitHub"
  git config --global http.https://github.com/.extraheader "Authorization: basic $GITHUB_TOKEN"
elif [[ $GITHUB_TOKEN != "" ]] && [[ $GHE_HOST != "" ]]; then
  echo "[$PREFIX] GHE user detected, setting up config..."
  git config --global http.$GHE_HOST/.extraheader "Authorization: basic $GITHUB_TOKEN"
else
  echo "[$PREFIX] No GitHub.com access token found. You may need to manually copy your PATs from"
  echo "[$PREFIX] your password manager or generate one if you have. Implementing SSH storage is still an"
  echo "[$PREFIX] work-in-progress thing for now. See https://cdrs-docs.rtapp.tk/setup-gh-pat for details."
  echo "[$PREFIX] Atleast repo (for private repos) or TODO (for public repos)"
fi
### GITLAB SAAS (gitlab.com) ###
if [[ $GITLAB_TOKEN != "" ]] && [[ $GITLAB_LOGIN != "" ]]; then
  echo "[$PREFIX] Setting up auth for GitLab SaaS"
  # shellcheck disable=SC2059
  printf "machine gitlab.com\nlogin $GITLAB_LOGIN\npassword $GITLAB_TOKEN\n" > ~/.netrc
elif [[ $GITLAB_TOKEN != "" ]] && [[ $GITLAB_LOGIN == "" ]] && [[ $GITLAB_HOST != "" ]]; then
  echo "[$PREFIX] Setting up auth for GitLab self-hosted"
  # shellcheck disable=SC2059
  printf "machine $GITLAB_HOST\nlogin $GITLAB_LOGIN\npassword $GITLAB_TOKEN\n" > ~/.netrc
else
  echo "[$PREFIX] No GitLab SaaS access token found. You may need to manually copy your PATs from your"
  echo "[$PREFIX] password manager or generate one if you have. Implementing SSH storage is still an"
  echo "[$PREFIX] work-in-progress thing for now. See https://cdrs-docs.rtapp.tk/setup-gh-pat for details."
fi

# function to clone the git repo or add a user's first file if no repo was specified.
project_init () {
    if [ -f "$START_DIR" ]; then
      echo "[$PREFIX] Fetching updates from remotes..."
      git fetch --all
    else
      [ -z "${GIT_REPO}" ] && echo "[$PREFIX] No GIT_REPO specified" && echo "Example file. Have questions? Join us at https://community.coder.com" > $START_DIR/coder.txt || git clone $GIT_REPO $START_DIR
    fi
}

# add rclone config and start rclone, if supplied
if [[ -z "${RCLONE_DATA}" ]]; then
    echo "[$PREFIX] RCLONE_DATA is not specified. Files will not persist"

    # start the project
    project_init

else
    echo "[$PREFIX] Copying rclone config..."
    mkdir -p /home/coder/.config/rclone/
    touch /home/coder/.config/rclone/rclone.conf
    echo "$RCLONE_DATA" | base64 -d > /home/coder/.config/rclone/rclone.conf

    # defasult to true
    RCLONE_VSCODE_TASKS="${RCLONE_VSCODE_TASKS:-true}"
    RCLONE_AUTO_PUSH="${RCLONE_AUTO_PUSH:-true}"
    RCLONE_AUTO_PULL="${RCLONE_AUTO_PULL:-true}"

    if [ "$RCLONE_VSCODE_TASKS" = "true" ]; then
        # copy our tasks config to VS Code
        echo "[$PREFIX] Applying VS Code tasks for rclone"
        cp /tmp/rclone-tasks.json /home/coder/.local/share/code-server/User/tasks.json
        # install the extension to add to menu bar
        code-server --install-extension actboy168.tasks&
    else
        # user specified they don't want to apply the tasks
        echo "[$PREFIX] Skipping VS Code tasks for rclone"
    fi

    # Full path to the remote filesystem
    RCLONE_REMOTE_PATH=${RCLONE_REMOTE_NAME:-code-server-remote}:${RCLONE_DESTINATION:-code-server-files}
    RCLONE_SOURCE_PATH=${RCLONE_SOURCE:-$START_DIR}
    echo "rclone sync $RCLONE_SOURCE_PATH $RCLONE_REMOTE_PATH $RCLONE_FLAGS -vv" > /home/coder/.local/bin/rclone-push
    echo "rclone sync $RCLONE_REMOTE_PATH $RCLONE_SOURCE_PATH $RCLONE_FLAGS -vv" > /home/coder/.local/bin/rclone-pull
    chmod +x "$HOME"/.local/bin/push_remote.sh "$HOME"/.local/bin/pull_remote.sh
    ln -s "$HOME"/.local/bin/rclone-{pull,push} "$HOME"/{pull,push}_remote.sh

    if rclone ls "$RCLONE_REMOTE_PATH"; then

        if [ $RCLONE_AUTO_PULL = "true" ]; then
            # grab the files from the remote instead of running project_init()
            echo "[$PREFIX] Pulling existing files from remote..."
            /home/coder/pull_remote.sh&
        else
            # user specified they don't want to apply the tasks
            echo "[$PREFIX] Auto-pull is disabled"
        fi

    else

        if [ "$RCLONE_AUTO_PUSH" = "true" ]; then
            # we need to clone the git repo and sync
            echo "[$PREFIX] Pushing initial files to remote..."
            project_init
            /home/coder/push_remote.sh&
        else
            # user specified they don't want to apply the tasks
            echo "[$PREFIX] Auto-push is disabled"
        fi

    fi

fi

echo "[$PREIFX] Updating package list caches..."
sudo apt update

echo "[$PREFIX] Starting code-server..."
# Now we can run code-server with the default entrypoint
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 "$START_DIR"
