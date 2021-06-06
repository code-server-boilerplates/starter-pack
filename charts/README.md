# Helm Charts for [Example Project]

## Deployment

### Using this repo

To install the chart, you need to clone the repo first locally, and you need [Helm](https://helm.sh/) installed (with your credientials file ready).

1. After cloning the repo and `cd` into it, edit the `charts/values.yaml` file.

```sh
$EDITOR charts/values.yaml
```

2. Deploy and hit the road!

```sh
helm upgrade --install charts -f values.yaml
```

3. Wait for the successful deploy notes to show in your terminal and follow instructions.

### Using our Helm Charts repo

It gone moved to [this page](https://github.com/code-server-boilerplates/starter-pack/blob/main/docs/deployment-guides/kubernetes.md). If you attempting to use this in Okteto Cloud, please [see this documentation](https://github.com/code-server-boilerplates/starter-pack/blob/main/docs/deployment-guides/kubernetes.md).

## Configuration and flags

See [the official Helm Chart's README](https://github.com/cdr/code-server/tree/main/ci/helm-chart#configuration) for details.
