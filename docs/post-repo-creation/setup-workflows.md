# Setting up GitHub Workflows

## Needed encrypted variables

After creating an new repo using this template, you should set encrypted
variables at repo level, if you prefer not to transfer the repo into `@code-server-boilerplates` org or you want to go on your own.

* `GH_SERVICE_ACCOUNT_API_KEY` - GitHub PAT with `repo`, `workflow` and `packages:write` (for pushing images to GHCR and also doing automated jobs in CI/CD), seperate bot account is recommended.
* `QUAYIO_{USERNAME,PASSWORD}` - Red Hat Quay Container registry username and password (bot accounts with atleast write access into the repo is recommended).
* `DOCKERHUB_{USERNAME,PASSWORD}` - Docker Hub username and password (access tokens MUST be used even if 2FA isn't enabled), seperate bot account is recommended.

**Note for template maintainers**: If you added more variables, you should document them here as much as possible.

## What to edit

In L7-9 of `.github/workflows/docker-cicd-{develop,release}.yml`, edit `env.{repository,namespace,namespace_dockerhub}` to match into the repository URL. Please be reminded that Docker Hub namespaces don't like dashes.

Remember that Docker image names only supports lowercase alphanumberic characters with only dashes, with exception of Docker Hub.

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

Once the new image is successfully propagated across the internet (you should wait up to 5 minutes before you can pull new builds), pull the image and use [our dev test kit](https://github.com/code-server-boilerplates/dev-testkit).

```
# pull latest dev builds first
# replace registry.domain.tld with your favorite container registries where your image lives
# or omit it althogether if you're on Docker Hub.
docker build registry.domain.tld/namespace/repo:develop

# clone our dev toolkit repo, and generate an new directory
git clone https://github.com/code-server-boilerplates/dev-testkit && cd dev-testkit
# template-name is needed so we can download the .env.example file
./scripts/generate-directory template-name registry.domain.tld/namespaxe/repo

# After generating it, edit its dotenv file we downloaded from the template's repo
./scripts/edit-dotenv template-name

# Now start things up (you can change directories after the init process)
./run template-name
```

Now, open your browser and navigate to `localhost:8080`, either get the password on the logs (if password generation is enabled) or use your own password and have fun testing stuff.
