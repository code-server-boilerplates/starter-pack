# Boilerplate for [Example Project]

In this boilerplate, we included the following packages out of the box:
* [`code-server`](https://github.com/cdr/code-server) for the VS Code in the browser
  * Add extensions here
* [`cloudflared`](https://todo.io) for accessing other ports through to Cloudflare Argo Tunnel
* Add more tools here

## Deploy 

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
