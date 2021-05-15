# Deploying `code-server` in Linode

1. Sign in to the Linode Cloud Dashboard.
   * Don't have an account? [Use this invite link](https://rtapp.tk/linode-thepinsteam) to support our work and get some credits to try the platform.
2. Go to StackScripts section of the sidebar.
3. Under **Community Scripts**, use `code-server-boilerplates/starter-pack`
or manually copy [the contents of `toolkits/virtual-machines/linode-bootstrapper`][linode-bootstrapper].
4. Give your server a label and deploy with Ubuntu 20.10 (or later) and any size.
Once your server starts, you can simply navigate to the IP address
and get forwarded to a secure version of code-server, which will
be proxied behind your GitHub account. For information on
how this works, see [`code-server --link`](https://github.com/cdr/code-server#cloud-program-%EF%B8%8F).
5. **Optional but recommended**: To change the URL in the address bar
from `linode-[xxxx]` to something more descriptive, you just
need to change your hostname and restart code-server:

```sh
sudo hostnamectl set-hostname that-should-be-done
sudo systemctl restart code-server@coder
```

[linode-bootstrapper]: toolkits/virtual-machines/linode-bootstrapper

## Configuring your instance
