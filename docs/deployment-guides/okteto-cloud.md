# Deploying on Okteto Cloud

While you may need to be on Developer Pro to use our Helm Chart repo, you can go through either the Git way or through manual option.

> **This step also applies to Okteto Enterprise users.** Through, you may need to sign in to your Okteto Enterprise instance through the CLI.

## Got Developer Pro?

1. Now, copy the following URL below first:

```
https://code-server-boilerplates.github.io/charts
```

2. Then navigate to your account settings, go to **Integrations**, click **Add new repository** and paste it. Hit save.

3. Go back to Namespaces page, press Deploy -> From Helm, and choose our chart repo. Select `starter-pack`, edit the `values.yaml` as needed and give it an name. Optionally choose an version if you want.

4. Ready? Hit Deploy and see you on the other side.

## Deploy with Git

1. Fork this repo to your account.

2. Edit `okteto-stacks.yaml` as needed. DO NOT COMMIT ANY SECRETS!

3. On Namespaces tab, hit Deploy -> From Git and either:
  * choose GitHub and seleft your repo
  * if you imported this repo in GitLab/Bitbucket/others, cop its clone URL, choose Git and paste it in the URL box.

4. Set the following variables:
  * `GENERATE_PASSWORD` - set to true, check the logs after deploy
  * `GITHUB_TOKEN` and `GITHUB_LOGIN` - your GitHub username and PAT (if you use GHE, also add `GHE_HOST`)
  * `GIT_REPO` - paste the Git repo you want to clone and work on
  * `GIT_USER_NAME` and `GIT_USER_EMAIL` - for commits and tags

5. Hit Deploy and wait for servers to get ready.

## The Manual Way

1. Download the kubeconfig file from your account settings page.

2. In an terminal, export the following variable woth this:

```sh
# replace /path/to/okteto-cloud-kubeconfig.yml into the path of your Okteto Kubeconfig file
# where you downloaded it
export KUBECONFIG=/path/to/okteto-cloud-kubeconfig.yml
```

3. Follow the rest of instructions [here](https://github.com/code-server-boilerplates/starter-pack/blob/main/charts/README.md#using-this-repo).
