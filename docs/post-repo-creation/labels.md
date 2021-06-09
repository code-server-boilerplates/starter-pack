# Issue and PR Labels

The following list are the labels you need for all the automation, among other things, to work. You can change the descriptio and hex color as you wish, but keep the name intact or things might break if you don't update your config too.

## Needed by Dependabot as per the configuration

| Name | Description | Hex Color |
| --- | --- | --- |
| Updated by Dependabot | Label for Mergify to automagically merge PRs from Dependabot | `#C3FB57` |
| dependencies | PRs with this label are usually contains dependency upgrades.| `#2E0D86` |
| ci/github-actions | Issues related to Code Server, mostly asked the issue author to move to the official repo. | `#1d76db` |
| packages/docker-base-images| Reserved for Dependabot Docker base image upgrades | `#e99695` |

## Labels for Automation through Mergify and PR Merge bot GH Actions

| Name | Description | Hex Color |
| --- | --- | --- |
| Ready to ship | PRs with this label are automagically merged by Mergify once approved. You can also add this through commenting LGTM for your bot account to approve it for you. | `#0E8A16` |
| Blocked from Merging | When added, PRs will be blocked until either Ready to Ship is added or this one is removed. | `#D93F0B` |
