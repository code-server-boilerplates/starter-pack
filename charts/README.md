# Helm Charts for [Example Project]

## Deployment

### Using this repo

To install the chart, you need to clone the repo first locally, and you need [Helm](https://helm.sh/) installed (with your credientials file ready).

1. After cloning, install the dependencies with `npm i` then run the `scripts/create-values-yaml` script. (Requires Node 10+)

```sh
# This will populate yout charts/values.yaml based on the examples
# subdirectory. It'll ask you whenever your cluster supports privileged
# containers, limits, among others.
./scripts/create-values
```

2. After the `charts/values.yaml` is generated, feel free to edit as you like.

```sh
$EDITOR charts/values.yaml
```

3. Deploy and hit the road!

```sh
helm upgrade --install charts -f values.yaml
```

### Using our Helm Charts repo

Todo

## Configuration and flags

Todo
