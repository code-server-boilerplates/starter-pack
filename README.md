# Boilerplate for [Example Project]

[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/4982/badge)](https://bestpractices.coreinfrastructure.org/projects/4982)
[![Docker CI (image development)](https://github.com/code-server-boilerplates/starter-pack/actions/workflows/docker-cicd-develop.yml/badge.svg)](https://github.com/code-server-boilerplates/starter-pack/actions/workflows/docker-cicd-develop.yml)

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
* [Homebrew on Linux](https://brew.sh) for installing tools without sudo - ~~Support for ARM are on best-effort basis, since there's [no bottles yet for 64-bit ARM-based systems](https://docs.brew.sh/Homebrew-on-Linux#arm).~~ We stopped building arm64 support for our images based on the official `codercom/code-server`, but we'll working on to bring it back using [Linuxserver.io's images](https://github.com/linuxserver/code-server) in the future.
* `jq` for prettifying your JSON stuff, especially if parsing JSON responses from some APIs.
* Basics like `curl`, `wget`, and more.
* Add more tools here

<!--
Note to new boilerplate maintainers: Explain what this template repo is for.
-->
This template repository is good for:

* people who want to start their own `deploy-code-server` template with all the things needed (including Helm Charts)
* just want to have the bare minimum dependencies in their `code-server` instance

## Checklist

Note to new template maintainers: After completing this checklist, update links below and reset progress if you marked your repository as an template.

* [X] [Generate an new repo](https://cdrs-deploy.repohubdev.tk/generate/example-project) for an specific user case or [duplicate this repo](/docs/duplicate-repo.md) to receive docs updates and more through the Pull app.
* [ ] [Complete this checklist](/docs/post-repo-creation/README.md) to setup GitHub Actions, among other things
* [ ] Replace any references by using the Search and Replace feature in VS Code (or any modern IDE).
  * Old reference to search: `{cdrs-starter-pack, starter-pack, [Example Project], code-server-boilerplates/starter-pack, example-project}`. (Proceed at your own risk if replacing all files using this regexp.)
* [ ] At `charts/Chart.yaml`, reset the version into `0.1.0`. Also change the Chart name and Artifact Hub annonations.
* [ ] Add your tools you want into `Dockerfile`. Just remember that anything requires `systemd` will not work (particularly Snaps and Flatpaks, AppImages are not fine).
  * Carefullu read the comments as you edit the file
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

* [ ] Update deployment docs in `docs/deployment-guides` directory. Ensure that replace any `https://cdrs-deploy.repohubdev.tk/<METHOD>/example-project` into `https://cdrs-deploy.repohubdev.tk/<METHOD>/<SLUGGIFIED-PROJECT-NAME-HERE>`. (`<METHOD>` is either `railway`, `heroku`, or `divio`, but every PaaS with Dockerfile support should be fine)
* [ ] Have any referral links for Linode or Digital Ocean? Replace `https://rtapp.tk/SERVICEHERE-thepinsteam` into `https://rtapp.tk/SERVICEHERE-yourusernamehere`. Remember to create these shortlinks using our Kutt.it instance at <https://rtapp.tk>. (`SERVICEHERE` is either `linode` or `digitalocean`)
* [ ] Change `Andrei Jiroh, Code Server Boilerplates maintainers, and its Contributors` in LICENSE file into `<Your name> and its Contributors` if you prefer not to bring this template into the `@code-server-boilerplates` org. Otherwise, change it into `<Your name>, Code Server Boilerplates maintainers, and its Contributors`.
* [ ] Create an PAT using your account (service account is always preferred and we usually use them here). If you prefer not to, [request for our service account's PAT](rtapp.tk/ghp-request-form) and invite `RecapTimeBot` into your repi as an collaborator (or as an outside collaborator with write access). Remember that the PAT we gave to you is valid for 2 years and can be renewable, as long as you comply with the policies.
* [ ] Adopt [the Community Code of Conduct](https://github.com/MadeByThePinsHub/policies/blob/main/CODE_OF_CONDUCT.md), which based on Contributor Convenant v2.0. If you prefer not to go to
* [ ] Finally, register your Code Server Boilerplate [here](https://cdr-deploy.repohubdev.tk/register) and our robots will send you both an invite into `@code-server-boilerplates` org through mail and also an new issue in your repo on instructions.
  * Once merged, we'll add your chart into our Helm Charts repo so you can see it on Artifact Hub and others to install it within the next hours or so.
* [ ] Cheer, you just made it here! Congratulate yourself! Now make an new release using `v0.1.0` as the tag name and `v0.1.0 - Initial release` as the release title. In the release description, describe the initial release as you prefer and publish! ([Example release description available](/docs/release-management/template.txt))
  * Probably now create new boilerplates straight to the org or even [join The Pins Team](https://rtapp.tk/join-thepinsteam) (it's optional btw, and if you're interested you'll be invited into `@MadeByThePinsHub/Community-Hubs-Network-Board` first by humans soon once you maintain atleast 3 boilerplates here, you can leave anytime) to help us maintain them, among other tasks.

Documentation for template maintainers [are now moving into this site](https://csb-docs.community-lores.gq) soon, as we're preparing
to make these `cdrs-docs.rtappp.tk` and `csb-docs.rtapp.tk` short links active within 3-6 months. For the build process, the Debian base image in the root
Dockerfile uses the official image from the upstream called `codercom/code-server` in Docker Hub.

### To fork or not to fork?

In order for your contributions to count, you need to either duplicate the repo or generate anew one based on this one (which making updating the maintainers' docs harder). As per the GitHub Docs, contributions from forks are not counted except when merged to the upstream.

## Deploy

Most deployment documentation are moved into  [the Guides section](/docs/deployment-guides).

### As an base image in your Dockerfile

In your Dockerfile, use `ghcr.io/code-server-boilerplates/starter-pack` as your base image and then add your needed tools.
Don't forget to publish your changes so GitHub Actions will publish them for you.

```dockerfile
# latest/stable = tracks latest image release
# develop = latest development image builds, usually new versions of code-server lands on first
# you can also drill down on commits based on their long SHA forms
FROM ghcr.io/code-server-boilerplates/starter-pack:latest
# Also the old cdr-*.<DISTRO-VERSION> is deprecated
# That same image is also available at RHQCR on same namespace and on
# Docker Hub as codeserverboilerplate as its namespace.

# ensures croc is up-to-date
RUN curl https://getcroc.schollz.com | sudo bash

# install our dotfiles
RUN git clone https://gitlab.com/MadeByThePinsHub/dotfiles /home/coder/.dotfiles
RUN bash /home/coder/.dotfiles/setup.sh --no-secrets-repo --noprompt --nosystemd

# no need for this one, but you can add it if needed
# CMD ["/usr/bin/cdr-launchpad-server"]
```

If you want to make your own deploy-code-server template by using our image, [here's the final product](https://github.com/code-server-boilerplates/starter-pack-as-base-image) you can generate from.

## Virtual machines/private servers or Docker containers?

- VMs are deployed once, and then can be modified to install new software
  - You need to save "snapshots" to use your latest images  - Storage is always persistent, and you can usually add extra volumes
  - VMs can support many workloads, such as running Docker or Kubernetes clusters
  - [Docs for the VM install script](toolkits/virtual-machines/)
- Deployed containers do not persist, and are often rebuilt
  - Containers can shut down when you are not using them, saving you money
  - All software and dependencies need to be defined in the `Dockerfile` or install script so they aren't destroyed on a rebuild. This is great if you want to have a new, clean environment every time you code
  - Storage may not be redundant. You may have to use [rclone](https://rclone.org/) to store your filesystem on a cloud service, for info:
  - [Docs for using the container image](toolkits/containers)

## Support, License and Contributing

Support resources are available at [SUPPORT.md](/SUPPORT.md) file.

This repository's contents is licensed under the MIT License.
By contributing to this repository or participating in the community, you agree to [Developer's Certificate of Origin][dco] and [The Pins Team Community Code of conduct](CODE_OF_CONDUCT.md).

[dco]: https://developercertificate.org
