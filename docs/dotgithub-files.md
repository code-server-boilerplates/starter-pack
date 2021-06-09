# `.github` Directory Documentation

_This copy of the documentation may be outdated. Please visit <https://cdrs-docs.rtapp.tk> for the latest revisions of these._

## Directory Structure

```
.github
├── ISSUE_TEMPLATE                # Issue Templates dir
│   └── config.yml                # issue template selector config
├── dependabot.yml                # For automating PRs regarding image upgrades
└── workflows                     # Stuff for GitHub Actions
    ├── docker-cicd-develop.yml   # Run CI for both PRs and main and only publish changes on main to the develop image tags.
    └── trigger-rebuild.yml    # workflow dispatcher to trigger an rebuild

```

## Issue and Pull Request Templates, Workflows

They're been moved to [the Post Repo Creation checklist](/docs/post-repo-creation/README.md) instead.
