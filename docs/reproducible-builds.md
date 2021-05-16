# Reproducible Builds

## Requirements

* Linux kernel 4.8+
* Docker 19.03+ (may need to enable experimental features first)

## Manually

Fitst, setup QEMU first so we can do multi-arch builds locally.

```bash
# pull the image
docker pull tonistiigi/binfmt:latest

# install QEMU static binaries
docker run --rm --privileged tonistiigi/binfmt:latest --install all
```

Then, setup Docker Buildx with our driver options defined in [the Push to Registry workflow file](/.github/workflows/push-to-registry.yml).

> Some flags don't work? Try updating Docker first. Also adjust them into your preference if the GitHub Action stuff we just pasted here looks kinda sus in security perspective.

```
# create an Buildx builder
docker buildx create --name code-server-boilerplates-reproduciblebuilds --driver docker-container --driver-opt image=moby/buildkit:master,network=host --buildkitd-flags --allow-insecure-entitlement security.insecure --allow-insecure-entitlement network.host --use

# the bootstrap it
docker buildx inspect --bootstrap --builder code-server-boilerplates-reproduciblebuilds
```

Finally, clone this repo and do the build.

```bash
# clone the repo first, make sure to replace the placeholder
# with your own repo
git clone git://github.com/code-server-boilerplates/starter-pack
cd starter-pack

# Build the main image
docker buildx build --platform linux/amd64,linux/arm64 .
```

### Without using the Docker image

This path maybe alot messier, but this should work in case the Docker way of installing binfmt-support on your Linux system didn't work or just want to use your distro's package manager instead.

```sh
# Debian, Ubuntu and its derivatives
sudo apt-get install -y qemu-user-static binfmt-support

# btw I use Arch people
TODO

# RHEL and Fedora
TODO
```
