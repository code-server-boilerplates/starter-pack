# Boilerplate for [Example Project]

In this boilerplate, we included the following packages out of the box:
* [`code-server`](https://github.com/cdr/code-server) for the VS Code in the browser
  * Add extensions here
* [`cloudflared`](https://todo.io) for accessing other ports through to Cloudflare Argo Tunnel
* [`croc`](https://github.com/schollz/croc) for sharing files between computers without that Mega.nz (or Telegram client) chaos
* Add more tools here

## Deploy

### As an base image

In your Dockerfile, use `code-server-boilerplates/starter-pack` as your base image
and then add your needed tools and finally the `RUN ["code-server","start"]` stuff at
the end.

```dockerfile
# Latest tag tracks the latest version of code-server
# Tags are formatted in form of BASE-IMAGE-NAME:cdr<CODE-SERVER-VER>
# For the base OS (we might do reproducible builds soon), use the format
# BASE-IMAGE-NAME:debian10 or BASE-IMAGE-NAME:ubuntu-latest (tl;dr: ubuntu-latest == latest LTS)
# where BASE-IMAGE-NAME is an image within code-server-boilerplates namespace
# in Docker Hub.
FROM code-server-boilerplates/starter-pack:latest

# ensures croc is up-to-date
RUN curl https://getcroc.schollz.com | sudo bash

# install our dotfiles
RUN git clone https://gitlab.com/MadeByThePinsHub/dotfiles /home/coder/.dotfiles
RUN bash /home/coder/.dotfiles/setup.sh --no-secrets-repo --noprompt --nosystemd

# finally, hit the road
PORT 3000
RUN ["/usr/local/bin/cdr-launchpad server" 
```

### As an container with Railway

1. Open this link: https://cdrs-deploy.repobuhdev.tk/railway/example-project
2. Fill the variables `GIT_REPO` and `PASSWORD` (preferrly using an generated password with
`openssl rand -hex 32` or with `Cmd+K` > **Generate Secret** and paste the resulting key).
3. Hit deploy and wait for the image build to succeed.
4. Open your project's publicly-accessible URL and hit the road.
   * When prompted for the password, copy the contents `PASSWORD` from the web UI.

### As an container with Heroku

1. Open this link: https://cdrs-deploy.repobuhdev.tk/heroku/example-project
2. Fill the variables `GIT_REPO` and `PASSWORD` (preferrly using an generated password with
`openssl rand -hex 32` and paste the resulting key from the terminal).
3. Hit deploy and wait for the image build to succeed.
4. Open your project's publicly-accessible URL and hit the road.
   * When prompted for the password, copy the contents `PASSWORD` from the web UI.

### As an VM in Linode

1. Sign in to the Linode Cloud Dashboard.
   * Don't have an account? [Use this invite link](https://rtapp.tk/linode-thepinsteam)
to support our work and get some credits to try the platform.

### As an VM in Digital Ocean

WIP
