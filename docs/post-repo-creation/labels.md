# Issue and PR Labels

The following list are the labels you need for all the automation, among other things, to work. You can change the descriptio and hex color as you wish, but keep the name intact or things might break if you don't update your config too.

## Managing labels with `.github/labels.json`

These labels are managed through the [`.github/labeler.json`](/.github/labels.json) file.
You can add new entries, edit or delete and once pushed they'll be automgaically updated via an workflow. You can trigger this CI through `workflow_dispatch` via UI (the workflow name is `Setup issue labels from file`) or API:

```sh
# Remember to replace owner/repo with the same values as GITHUB_REPOSITORY.
curl -i -H "Authorization: Bearer GH_TOKEN_HERE" \
    -X POST -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/owner/repo/actions/workflows/setup-issue-labels.yml/dispatches \
    -d '{"ref":"main"}'
```

Remember that any removed entry in that JSON files are not reflected, so you may need to remove it from the UI/API first.

### Syntax

Each object has it own `name`, `color` and `description` values.
```json
[
  {
    "name": "code-server",
    "color": "1d76db",
    "description": "Issues related to Code Server, mostly asked the issue author to move to the official repo."
  }
]
```

* `name` - _Required._ The label name.
* `color` - _Required._ The label's color in Hex code without `#` when shown in the web UI.
* `description` - _Optional._ The label description.

## Labels List

### Needed by Dependabot as per the configuration

| Name | Description | Hex Color |
| --- | --- | --- |
| Updated by Dependabot | Label for Mergify to automagically triage PRs from Dependabot | `#C3FB57` |
| dependencies | PRs with this label are usually contains dependency upgrades. | `#2E0D86` |
| ci/github-actions | Issues related to Code Server, mostly asked the issue author to move to the official repo. | `#1d76db` |
| packages/docker-base-images| Changes to fhe base image, including upgrades made by Dependabot. | `#e99695` |
| packages/nodejs-npm | PRs releated to upgrading Node.js tools we use like Commitizen and Commitlint. | 38E1F1 |

### Automation through Mergify, GitHub Actions and Other Integrations

| Name | Description | Hex Color |
| --- | --- | --- |
| Ready to ship | PRs with this label are automagically merged by Mergify once approved. You can also add this through commenting LGTM for your bot account to approve it for you. | `#0E8A16` |
| Blocked from Merging | When added, PRs will be blocked until either Ready to Ship is added or this one is removed. | `#D93F0B` |
| WIP | Same as Blocked from Merging but used on draft PRs and WIPs. | D79D00 |

### Meta Labels

| Name | Description | Hex Color |
| --- | --- | --- |
| code-server | Issues related to Code Server, mostly asked the issue author to move to the official repo. | `#1d76db` |
