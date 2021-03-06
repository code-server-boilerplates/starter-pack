# Installing the Helm Chart

This repo has Helm Charts support so you can easily deploy your code to Kubernetes, based on [the upstream's files](https://github.com/cdr/code-server/tree/main/ci/helm-chart).
As usual, docs for installing the chart using this repo are over [here](/charts/README.md).
For the rest of the documentation, for the rest of this documentation we'll use our GitHub Pages-hosted Charts repo.

## Installating this Chart

1. As usual, add our Helm Charts repo into your local installation of Helm.

```sh
# to use the primary repo, you need to remove our mirrors first.
helm repo add deploy-code-server https://code-server-boilerplates.github.io/charts

# to use official mirrors, you may need to remove the current one.
# They'll be go online soon, so don't get hyped!
helm repo add cdrs-deploy https://csb-charts.netlify.app
```

2. Added to already? Update your local caches with `helm repo update`.

3. Download our example `values.yaml` from GitHub with wget.

```sh
wget https://raw.githubusercontent.com/code-server-boilerplates/starter-pack/main/charts/values.yaml
```

4. With your favorite text editor, customize your installation first.

```sh
# asumming that $EDITOR is Vim, so you can't exit anymore (just kidding)
$EDITOR values.yaml
```

5. Finally, deploy the chart and hit the road.

```sh
# change my-starter-pack to whatever name you want
helm install my-starter-pack deploy-code-server/starter-pack -f values.yaml
```

6. To update the chart on your Kubernetes cluster or update its configuration, just do:
```sh
# if updating the chart itself, please do this first
helm repo update

# change my-starter-pack to whatever name you used
# when you did step 5.
helm upgrade my-starter-pack deploy-code-server/starter-pack -f values.yaml
```

## Deploying without Helm

We don't want to do yet another chaos manangement in adding friction to deploying your own code-server instances in Kubernetes. Please, use Helm instead.
