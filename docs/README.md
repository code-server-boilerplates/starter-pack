# Documentation homepage

Welcome to the documentation page for maintainers, contributors and regular users alike!
This documentation may be outdated, so the canonical source is at
<https://cdrs-docs.rtapp.tk>.

## For regular users

* [Deployment Guides](deployment-guides/README.md) - Want to just deploy instead of maling anew repo first? Use this guide to learn more.
* [Helm Charts](charts/README.md) - Documentation for the Helm Charts

## For maintainers

### After creating an fresh repo

[Open the general README](post-repo-creation/README.md) for details.

* [Setup Workflows](post-repo-creation/setup-workflows.md) - Setup GitHub Actions like configuring encrypted variables.
* [Repo Settings](post-repo-creation/settings.md) - Which features we recommend to enable or disable, adjusting branch protection rules, and adding collaborators, among others.
* [Issue and PR Labels](post-repo-creation/labels.md) - What labels to add for different use cases.
* [Issue and PR templates](post-repo-creation/templated.md) - Updating templates and contact links in the template chooser screen.
* [Configuring Mergify](post-repo-creation/mergify.md) - we use Mergify to automagically merge Dependabot PRs on the base images and also notify you when one of Node.js tools we recommend to use needs an upgrade.

### Misc

* [`.github/` files](dotgithub-files.md) - Docs for maintaing the `.github/` directory, among other things.
* [Manuallly/Reproducing Image Builds](reproducible-builds.md) - If you ever want to reproduce builds manually or use other CI, you may need to setup Buildx and QMEU first.

---

The documentation is also viewable on [Notion](https://notion.so/404notfound)
