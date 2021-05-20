# `.github` Directory Documentation

_[Go back to main documentation](/README.md)_

## Directory Structure

```
.github
├── ISSUE_TEMPLATE             # Issue Templates dir
│   └── config.yml             # issue template selector config
├── README.md                  # You're here!
├── dependabot.yml             # For automating PRs regarding image upgrades
└── workflows                  # Stuff for GitHub Actions
    ├── image-builds-pr.yml    # Build images for PRs (multi-arch)
    ├── push-to-registry.yml   # Push builds to GHCR, DockerHub and Quay.io
    └── trigger-rebuild.yml    # workflow dispatcher to trigger an rebuild

```

## Any required apps?

* [Mergify](https://github.com/marketplace/mergify) to automagically
merge PRs based on rules (Dependabot, etc.) - Remove this file to use
GitHub Actions, which maybe disabled by the post-repo creation workflow
that you manually triggered.

## Workflows Stuff

### First Things First

After creating an new repo using this template, you should set encrypted
variables at repo level, if you prefer not to transfer the repo into `@code-server-boilerplates` org.

- `GH_SERVICE_ACCOUNT_API_TOKEN` - GitHub API token with `repo`, `workflow` and `write:packages` permissions (after enabling enhanced containner support on your account or org), preferrly using an bot account.
- `DOCKERHUB_USERNAME` and `DOCKERHUB_PASSWORD` - Use an access token for your Docker Hub account (enable 2FA to force Docker clients to use access tokens).
- `QUAYIO_USERNAME` and `QUAYIO_PASSOWRD` - Quay.io login infos
  - For the username, we prefer to use bot accounts, so if you made one, it should be `code-server-boilerplates+github_actions`, where `code-server-boilerplates` is your Quay.io namespace/org.

If you wish to transfer the repo into that said org, we recommend to remove any existing encrypted variables if you prefer to use org-wide ones. Once transferred, we'll magically edit your workflow files for you if these variables are not found at repo-level.

### Manually trigger an image build

Because the image builds only happens when either `Dockerfile` or `.trigger-rebuild` files are changed as we defined below...

> New image pushes to the registries will be ONLY happen if pushed to the `main` branch.

```yml
# L3-8 on workflows/push-to-registry.yml
on:
  push:
    paths:
      - "Dockerfile"
      - ".trigger-rebuild"
```

...you may need to do these instead:

```bash
# manual way
## generate an random base64 trasb
date | base64 > .trigger-rebuild
## stage and commit
git add .trigger-rebuild
git commit --signoff -m 'chore(github-actions): Manually trigger Docker builds CI'
## push
git push

# or via API
## remember to replace GH_TOKEN_HERE with your PAT
# and owner/owner with your repo's URL without https://github.com/ part
curl -i -H "Authorization: Bearer GH_TOKEN_HERE" \
    -X POST -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/owner/repo/actions/workflows/trigger-rebuild.yml/dispatches \
    -d '{"ref":"main"}'
```

### Upgrading code-server base images

Base image upgrades are automagically handled by [Dependabot][dbot]
(the same bot is used for updating GitHub Actions)
