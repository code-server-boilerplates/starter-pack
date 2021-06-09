# Configuring Mergify

Installing Mergify is recommended, but if you prefer to use GitHub Actions instead, [see this workflow file](/.github/workflows/pr-merger-bot.yml).

## Installing Mergify

If your template is on the `code-servee-boilerplates` org or wants to trnasfer to there, skip the installation step altogether.

1. Go to <https://github.com/apps/mergify/installations/new> and choose your account or org where your template repo resides.
2. Choose which repos you allow the app to access to.
    * For use in one repo (aka your template repo), select **Only select repositories** and select yours.
    * If you want them all, choose **All repositories**.
3. Finally hit `Install` button. You'll be redirected to Mergify Dashboard.

## Additional Configuration Needed

In line 36 on `.mergify.yml`, replace `AndreiJirohHaliliDev2006` inti
your username to get assigned.

## Example Configurations

Pick once, paste into your `.mergify.yml` file and customize as needed. More will be added soon.

* Automagically merge Dependabot PRs

```yml
# Conflicts with the following PR rules, please comment them out first:
# - Automate base image upgrade review process from Dependabot
# - Ship Dependabot PRs when approved by humans
# Remember that you MUST ALWAYS REVIEW THE CHANGELOGS
# before your release it as https://github.io/cdr/code-server/releases.
  - name: Automagically ship Dependabot PRs
    conditions:
      - author~=^dependabot(|-preview)\[bot\]$
      - label=Updated by Dependabot
      - label=packages/docker-base-images
      - base=main
    actions:
      review:
        type: APPROVE
        message: |
           Approving and merging @dependabot's pull request, to be
           shipped in the following image tags: `develop`

           Maintainers have been advised to to create an new release regarding
           this base image upgrade as soon as possible for patches, including security fixes, and
           within the next 48-72 hours for minor releases.
           For major releases, expect breaking changes and notify your users accordingly before creating an new GitHub release.

           To learn more about this guideline, please read your `docs/release-management/automated-base-image-upgrades.md` or
           through <https://cdrs-docs.rtapp.tk/base-images-dependabot
           in case your copy of maintainers' docs go outdated.

           --

           This PR has been merged automagically by Mergify.
           Read `docs/post-repo-creation/mergify.md` or visit <https://cdrs-docs.rtapp.tk/mergify>
           to learn more.
      merge:
        action: merge
```

## Reminders

Don't use both Mergify and [the merging bot workflow](/.github/workflows/pr-merger-bot.yml) or things might turn into chaos.

## FAQ

### Why assigning my bot account even if it's not used?

We assign your bot account automatically in case you're lazy enough
to approve the PR and add the `Ready ti Ship` label. To do that,
just type `@your-bot-account-here LGTM` (or the shortcut `LGTM`, through
you need your repo musy belong to an org to use teams).
