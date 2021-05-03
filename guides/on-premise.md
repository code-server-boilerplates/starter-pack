# Deploying `code-server` using the bootstrapper script

> :warning **General bootstrapper script only works with the root user.** You may need to do `sudo su` first.

In an terminal, run the following command:

```sh
# as of time of writing, only Debian and Debian-based distros like Ubuntu are supported in this script for now
# also systemd is needed for some commands, but we'll fix that in the future.
# PRs are always welcome! Once we're receiving contributions, we will make that script an wrapper for getting the right script for each OS.
# Windows and macOS users, please fuck off. (see FAQs for that)
curl https://cdrs-deploy.repohubdev.tk/bootstrapper/example-project | basb
```

## FAQs

## Do you support air-gapped installs?

We're sorry to say, but you need to temporarily connect to the internet to run the installer.

## How about Windows and macOS?

We're sorry if we said `fuck off`, but we'll working on it.
Soon. PRs are always welcome.
