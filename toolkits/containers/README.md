# Container Toolkits for [starter-pack]

An container image built for deploying code-server plus
containing the essiential tools you need in your cloud dev
environment

## Guides

[See the guides directory](/guides) for deployment instructions.

## Available Images

<!--
Note to maintainers: Update links to your Docker images below!
-->

* Docker Hub Image: [`code-server-boilerplates/starter-pack`](https://hub.docker.com/r/code-server-boilerplates/starter-pack)
* GitHub Container Registry Image; [`ghrc.io/code-server-boilerplates/starter-pack`](https://github.com/)

## Modifying your code-server environment

To update your code-server version, modify the version number on line 2 in your Dockerfile. See the [list of tags](https://hub.docker.com/r/codercom/code-server/tags?page=1&ordering=last_updated) for the latest version. (Please don't use `latest` tag to avoid unwanted surprises.)

We've included some examples on how to add additoonal dependencies in the root-level [Dockerfile](/Dockerfile):

``` Dockerfile
# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
RUN sudo apt-get install -y ubuntu-make

# Copy files: 
COPY toolkits/packages/@rtapp-non-thejuicemedia-ref/DO-NOT-MERGE.gildedguy-and-yoopia /home/coder/.local/more-corporate-clickbait-bullshit.headquarters.com.au
```

---

## Environment variables

| Variable Name     | Description                                                                                      | Default Value       |
| ----------------- | ------------------------------------------------------------------------------------------------ | ------------------- |
| `PASSWORD` | Password for code-server                                                                                |                     |
| `HASHED_PASSWORD` | Overrrides PASSWORD. [SHA-256 hash](https://xorbin.com/tools/sha256-hash-calculator) of password |
| `USE_LINK` | Use code-server --link instead of a password (coming soon)                                              | false               |
| `GIT_REPO` | A git repository to clone                                                                               |                     |
| `START_DIR` | The directory code-server opens (and clones repos in)                                                  | /home/coder/project |
| `GIT_USER_EMAIL` | An email address to be used in commits and tags                                                   | RecapTime@users.noreply.github.com |
| `GIT_USER_NAME` | An screen name to be used in commits and tags                                                      | Recap Time Bot |
| `GITHUB_TOKEN` | GitHub.com/GHE personal access token                                                                |                |
| `GHE_HOST`     | GitHub Enterprise hostname                                                                          | github.com     |
| `GITLAB_LOGIN` | GitLab username                                                          |                |
| `GITLAB_TOKEN` | GitLab SaaS personal access token                                                              |                |
| `GITLAB_HOST`  | GitLab CE/EE instance domain (without HTTP protocol)                                            | `gitlab.com`  |

Other code-server environment variables (such as `CODE_SERVER_CONFIG` ) can also be used. See the [code-server FAQ](https://github.com/cdr/code-server/blob/main/docs/FAQ.md) for details.

## 💾 Persist your filesystem with `rclone`

_(atleast your project files in `/home/coder/project`)_

This image has built-in support for [rclone](https://rclone.org/) so that your files don't get lost when code-server is re-deployed.

You can generate the rclone config on any machine, but it works great on the code-server environment itself, or Google Cloud Shell :)

``` sh
# 1. install rclone
# see https://rclone.org/install/ for other install options
$ curl https://rclone.org/install.sh | sudo bash

# 2. create a new rclone remote with your favorite storage provider ☁️
$ rclone config

# 3. Encode your rclone config and copy to your clipboard
$ cat $(rclone config file | sed -n 2p) | base64 --wrap=0 # Linux
$ cat $(rclone config file | sed -n 2p) | base64 --b 0 # MacOS
```

Now, you can add the following the environment variables in the code-server cloud app:

| Environment Variable | Description                                                                                                                                           | Default Value                                | Required |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | -------- |
| RCLONE_DATA          | the encoded rclone config you copied in step 3                                                                                                        | n/a                                          | ✅        |
| RCLONE_REMOTE_NAME   | the name of the remote you added in step 2.<br />check with `$ rclone listremotes` | code-server-remote                           |          |
| RCLONE_SOURCE        | source directory to sync files in the code-server container                                                                                           | the project directory: `/home/coder/project` |          |
| RCLONE_DESTINATION   | the path in the remote that rclone syncs to. change this if you have multiple code-server environments, or if you want to better organize your files. | code-server-files                            |          |
| RCLONE_VSCODE_TASKS  | import push and pull shortcuts into VS Code ![rclone screenshot from VS Code](../img/rclone-vscode-tasks.png) | true |
| RCLONE_AUTO_PUSH     | automatically push files on startup if the rclone remote is empty (environment -> rclone remote)                                                      | true                                         |          |
| RCLONE_AUTO_PULL     | automatically pull files on startup if the rclone remote is not empty (rclone -> environment remote)                                                  | true                                         |          |
| RCLONE_FLAGS         | additional flags to attach to the push and pull script.<br />type `$ rclone help flags` for a list.                                                          |                                              |          |

``` sh

# --- How to use ---

# Terminal:
$ sh /home/coder/push_remote.sh # save your uncomitted files to the remote
$ sh /home/coder/pull_remote.sh # get latest files from the remote

# In VS Code:
# use items in bottom bar or ctrl + P, run task: push_remote or pull_remote or 
```

### Popular rclone flags

To avoid syncing unnecessary directories, add this to
`RCLONE_FLAGS` variable:

``` none
--exclude "node_modules/**" --exclude ".git/**"
```

---

## Todo

* [ ] Make `push_remote` and `pull_remote` commands in path
as functions
* [ ] Impliment file watcher or auto file sync in VS Code
* [ ] Attach a "push" on stashes in Git?
* [ ] Add support for SSH / VS Code remote access (for containers
we need some Cloudflare Argo Tunneling magic)
* [ ] Make rclone logs visible in environment for debugging
