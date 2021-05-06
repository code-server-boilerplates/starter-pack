# Boilerplate for [Example Project]

<!--
Note to new boilerplate maintainers: Please update this part
to include the tools you're added into the bootstrapper
scripts and into the main Dockerfile.
-->
In this boilerplate, we included the following packages out of the box:
* [`code-server`](https://github.com/cdr/code-server) for the VS Code in the browser
  * Add extensions here
* [`cloudflared`](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps) for accessing other ports through to [Cloudflare Argo Tunnel](https://www.cloudflare.com/en-gb/products/argo-tunnel/)
* [`croc`](https://github.com/schollz/croc) for sharing files between computers without that Mega.nz (or Telegram client) chaos
* Add more tools here

<!--
Note to new boilerplate maintainers: Explain what this
template repo is for.
-->
This template repository is good for:
* people who want to start their own Code Server Boilerplates
* just want to have the bare minimum dependencies in their `code-server` instance.

## Checklist

* [X] [Generate an new repo](https://cdrs-deploy.repohubdev.tk/generate/example-project) for an specific user case.
* [ ] Replace any placeholder references such as `[Example Project]` and `code-server-boilerplates/starter-pack` in README and also in `toolkits/containers/README.md`.
* [ ] Add your tools you want into `Dockerfile`. Just remember that anything requires `systemd` will not work (particularly Snaps and Flatpaks, AppImages are fine).
* [ ] Edit `toolkits/virtual-machines/*bootstrapper` scripts to include needed tools lile what you did in your Dockerfile (optional, but recommended). Now, feel free to add systemd-required tools like Snaps, just look for these lines.

```sh
############################################################
# Add your tools your users want to install on an fresh machine here ⬇

# For userland installs, like Node Version Manager,
# you may need to prefix "su coder" before the command.
# For global installs, nuke the sudo part since we're root.

# ...

# Add your tools your users want to install on an fresh machine here 
############################################################
```

* [ ] Update deployment docs in `guides` directory. Ensure that replace any `https://cdrs-deploy.repohubdev.tk/<METHOD>/example-project` into `https://cdrs-deploy.repohubdev.tk/<METHOD>/<SLUGGIFIED-PROJECT-NAME-HERE>`. (`<METHOD>` is either `railway`, `heroku`, or `divio`, but every PaaS with Dockerfile support should be fine)
* [ ] Have any referral links for Linode or Digital Ocean? Replace `https://rtapp.tk/SERVICEHERE-thepinsteam` into `https://rtapp.tk/SERVICEHERE-thepinsteam`. Remember to create these shortlinks using our Kutt.it instance at <https://rtapp.tk>. (`SERVICEHERE` is either `linode` or `digitalocean`)
* [ ] Change `Andrei Jiroh, Code Server Boilerplates maintainers, and its Contributors` in LICENSE file into `<Your name> and its Contributors` if you prefer not to bring this template into the `@code-server-boilerplates` org. Otherwise, change it into `<Your name>, Code Server Boilerplates maintainers, and its Contributors`.
* [ ] Adopt [the Community Code of Conduct](https://github.com/MadeByThePinsHub/policies/blob/main/CODE_OF_CONDUCT.md), which based on Contributor Convenant v2.0.
* [ ] Finally, register your Code Server Boilerplate [here](https://cdr-deploy.repohubdev.tk/register) and our robots will send you both an invite into `@code-server-boilerplates` org through mail and also an new issue in your repo on instructions.
* [ ] Cheers! You just made it here. Probably now create new boilerplates straight to the org or even [join The Pins Team](https://rtapp.tk/join-thepinsteam) (it's optional btw, and if you're interested you'll be invited into `@MadeByThePinsHub/Community-Hubs-Network-Board` first by humans soon once you maintain atleast 3 boilerplates here, you can leave anytime) to help us maintain them, among other tasks.

## Deploy

More deployment documentation are available in [the Guides section](/guides).

### As an base image in your Dockerfile

In your Dockerfile, use `code-server-boilerplates/starter-pack` as your base image
and then add your needed tools and finally the `CMD ["cdr-launchpad-server]` stuff at the end.

```dockerfile
# Latest tag tracks the latest version of code-server
# Tags are formatted in form of BASE-IMAGE-NAME:cdr<CODE-SERVER-VER>
# For the base OS (we might do reproducible builds soon), use the format
# BASE-IMAGE-NAME:debian10 or BASE-IMAGE-NAME:ubuntu-latest (tl;dr: ubuntu-latest == latest LTS)
# Also using the latest tag will use the image we built using the same Dockerfile.
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

## code-server on a VM vs. a Container

- VMs are deployed once, and then can be modified to install new software
  - You need to save "snapshots" to use your latest images
  - Storage is always persistent, and you can usually add extra volumes
  - VMs can support many workloads, such as running Docker or Kubernetes clusters
  - [Docs for the VM install script](toolkits/virtual-machines/)
- Deployed containers do not persist, and are often rebuilt
  - Containers can shut down when you are not using them, saving you money
  - All software and dependencies need to be defined in the `Dockerfile` or install script so they aren't destroyed on a rebuild. This is great if you want to have a new, clean environment every time you code
  - Storage may not be redundant. You may have to use [rclone](https://rclone.org/) to store your filesystem on a cloud service, for info:
  - [Docs for using the container image](toolkits/containers)

## License and Contributing

This repository's contents is licensed under MIT License. By contributing to
this repository, you agree to [Developer's Certificate of Origin][dco]
and [The Pins Team Community Code of conduct](CODE_OF_CONDUCT.md).

[dco]: https://developercertificate.org
