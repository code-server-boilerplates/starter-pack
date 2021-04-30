# Boilerplate for [Example Project]

In this boilerplate, we included the following packages out of the box:
* [`code-server`](https://github.com/cdr/code-server) for the VS Code in the browser
  * Add extensions here
* [`cloudflared`](https://todo.io) for accessing other ports through to Cloudflare Argo Tunnel
* [`croc`](https://github.com/schollz/croc) for sharing files between computers without that Mega.nz (or Telegram client) chaos
* Add more tools her

This template repository is good for:
* people who want to start their own Code Server Boilerplates
* just want to have the bare minimum dependencies in their `code-server` instance.

## Checklist

* [X] [Generate an new repo](https://cdrs-deploy.repohubdev.tk/generate/example-project) for an specific user case.
* [ ] Replace any placeholder references such as `[Example Project]` and `code-server-boilerplates/starter-pack` in README and also in `toolkits/containers/README.md`.
* [ ] Add your tools you want into `Dockerfile`. Just remember that anything requires `systemd` will not work (particularly Snaps and Flatpaks, AppImages are fine).
* [ ] Edit `toolkits/virtual-machines/*bootstrapper` scripts to include needed tools lile what you did in your Dockerfile (optional, but recommended). Now, feel free to add systemd-required tools like Snaps.
* [ ] Update deployment docs below! Ensure that replace any `https://cdrs-deploy.repohubdev.tk/<METHOD>/example-project` into `https://cdrs-deploy.repohubdev.tk/<METHOD>/<SLUGGIFIED-PROJECT-NAME-HERE>`. (`<METHOD>` is either `railway`, `heroku`, or `divio`, but every PaaS with Dockerfile support should be fine)
* [ ] Have any referral links for Linode or Digital Ocean? Replace `https://rtapp.tk/SERVICEHERE-thepinsteam` into `(https://rtapp.tk/SERVICEHERE-thepinsteam`. Remember to create these shortlinks using our Kutt.it instance at <https://rtapp.tk>. (`SERVICEHERE` is either `linode` or `digitalocean`
* [ ] Finally, register your Code Server Boilerplate [here](https://cdr-deploy.repohubdev.tk/register) and our robots will send you both an invite into `@code-server-boilerplates` org through mail and also an new issue in your repo on instructions.
* [ ] Cheers! You just made it here. Probably now create new boilerplates straight to the org or even [join The Pins Team](https://rtapp.tk/join-thepinsteam) (you'll be invited into `@MadeByThePinsHub/Community-Hubs-Network-Board` first by humans soon once you maintain atleast 3 boilerplates here, you can leave anytime) to help us maintain them, among other tasks.

## Deploy

### As an base image

In your Dockerfile, use `code-server-boilerplates/starter-pack` as your base image
and then add your needed tools and finally the `CMD ["cdr-launchpad-server]` stuff at the end.

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
PORT 8080
CMD ["/usr/bin/cdr-launchpad-server"]
```

### As an container with Railway

1. Open this link: https://cdrs-deploy.repohubdev.tk/railway/example-project
2. Fill the variables `GIT_REPO` and `PASSWORD` (preferrly using an generated password with
`openssl rand -hex 32` or with `Cmd+K` > **Generate Secret** and paste the resulting key).
3. Hit deploy and wait for the image build to succeed.
4. Open your project's publicly-accessible URL and hit the road.
   * When prompted for the password, copy the contents `PASSWORD` from the web UI.

### As an container with Heroku

1. Open this link: https://cdrs-deploy.repohubdev.tk/heroku/example-project
2. Fill the variables `GIT_REPO` and `PASSWORD` (preferrly using an generated password with
`openssl rand -hex 32` and paste the resulting key from the terminal).
3. Hit deploy and wait for the image build to succeed.
4. Open your project's publicly-accessible URL and hit the road.
   * When prompted for the password, copy the contents `PASSWORD` from the web UI.

### As an VM in Linode

1. Sign in to the Linode Cloud Dashboard.
   * Don't have an account? [Use this invite link](https://rtapp.tk/linode-thepinsteam) to support our work and get some credits to try the platform.
2. Go to StackScripts section of the sidebar.
3. Under **Community Scripts**, use `code-server-boilerplates/starter-pack`
or manually copy [the contents of `toolkits/virtual-machines/linode-bootstrapper`][linode-bootstrapper].
4. Give your server a label and deploy with Ubuntu 20.10 (or later) and any size.
Once your server starts, you can simply navigate to the IP address
and get forwarded to a secure version of code-server, which will
be proxied behind your GitHub account. For information on
how this works, see [`code-server --link`](https://github.com/cdr/code-server#cloud-program-%EF%B8%8F).
5. **Optional but recommended** To change the URL in the address bar
from `linode-[xxxx]` to something more descriptive, you just
need to change your hostname and restart code-server:

```sh
sudo hostnamectl set-hostname that-should-be-done
sudo systemctl restart code-server@coder
```

[linode-bootstrapper]: toolkits/virtual-machines/linode-bootstrapper

### As an VM in Digital Ocean

WIP
