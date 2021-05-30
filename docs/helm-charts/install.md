# Installing the Helm Chart

This repo has Helm Chart support, based on [the upstream's files](https://github.com/cdr/code-server/tree/main/ci/helm-chart).

```bash
# clone the repo first
git clone https://github.com/code-server-boilerplates/starter-pack
cd starter-pack

# assuming that you have your Kubernetes config with you
# (e.g. using Okteto Cloud) or have your own cluster within
# your network, deploy and hit the road.
helm upgrade --install cdrs-starter-pack .
```

You can also optionally configure yours in the `.helm-config` directory. Examples are being provided with the `-example` suffix if you need some examples.

To use your `.helm-cofig` files, run:

```sh
# Files should be on .helm-charts for the script to include during the
# chart installation process.
./scripts/install-helm-chart init.yml custom-values.yml

# or you can do this instead:
$ helm upgrade --install cdrs-starter-pack . -f .helm-config/values.yaml
```
