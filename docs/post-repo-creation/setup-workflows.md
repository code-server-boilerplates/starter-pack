# Setting up GitHub Workflows

## Needed encrypted variables

After creating an new repo using this template, you should set encrypted
variables at repo level, if you prefer not to transfer the repo into `@code-server-boilerplates` org or you want to go on your own.

* `GH_SERVICE_ACCOUNT_API_KEY` - GitHub PAT with `repo`, `workflow` and `packages:write` (for pushing images to GHCR and also doing automated jobs in CI/CD), seperate bot account is recommended.
* `QUAYIO_{USERNAME,PASSWORD}` - Red Hat Quay Container registry username and password (bot accounts with atleast write access into the repo is recommended).
* `DOCKERHUB_{USERNAME,PASSWORD}` - Docker Hub username and password (access tokens MUST be used even if 2FA isn't enabled), seperate bot account is recommended.

**Note for template maintainers**: If you added more variables, you should document them here as much as possible.

## What to edit

In L7 of `.github/workflows/docker-cicd-{develop,release}.yml`, edit `env.repository` to match into the repository URL.

Remember that Docker image names only supports lowercase alphanumberic characters with only dashes.

## Testing out changes

To test out changes outside `toolkits/containers` and `toolkits/packages/scripts` directories and `Dockerfile`, you need to manually do an `workflow_dispatch` to `Trigger Docker Builds CI` workflow.

If you're on your machine with your repo cloned, assuming you pulled latest changes fron remote:

```sh
cd /path/to/your/repo
date | base64 > .trigger-rebuild
git add .trigger-rebuild
git commit -m "chore(github-actions): manually trigger image builds CI" --signoff && git push
```

You can also trigger this workflow through the API with this cURL command:

```
# Remember to replace owner/repo with the same values as GITHUB_REPOSITORY.
curl -i -H "Authorization: Bearer GH_TOKEN_HERE" \
    -X POST -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/owner/repo/actions/workflows/trigger-rebuild.yml/dispatches \
    -d '{"ref":"main"}'
```
