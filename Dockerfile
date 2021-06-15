# Start from the code-server Debian base image
FROM codercom/code-server:3.10.2

# Add image labels here, but read comments as you edit
# Replace code-server-boilerplates with username-here/repo
LABEL org.opencontainers.image.source="https://github.com/code-server-boilerplates/starter-pack" \
      org.opencontainers.image.vendor="code-server Community" \
      org.opencontainers.image.documentation="https://cdrs-docs.rtapp.tk"

# Update PATH to enusre both user-wide scripts and our stuff
# on /usr/local/bin are available to summon
ENV PATH="/usr/local/bin:/home/coder/.local/bin:$PATH" \
    # prefix for thr entrypoint logs, in which you should update into
    # @namespace/template-slug
    TEMPLATE_SLUG_PREFIX="@code-server-boilerplates/starter-pack"

USER root
# use Bash by default
RUN echo "[code-server] Image build starts on $(arch)" \
    && chsh -s /bin/bash coder && chsh -s /bin/bash

# Use bash shell, just in case.
ENV SHELL=/bin/bash

# Init Gitpod-styled workspace directory. This is needed to only
# presist files mounted into volumes
RUN mkdir /workspace && touch hello-world \
    && chown -R coder:coder /workspace

USER coder
# Apply VS Code settings
COPY toolkits/containers/settings.json .local/share/code-server/User/settings.json

# Install unzip + rclone (support for remote filesystem)
# Also don't forget wget for that. jq included too
RUN sudo apt-get update \
    && sudo apt-get install unzip jq wget tree -y \
    && curl https://rclone.org/install.sh | sudo bash

# Copy rclone tasks to /tmp, to potentially be used
COPY toolkits/containers/rclone-tasks.json /tmp/rclone-tasks.json

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder/.local

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use Open VSIX as the extension marketplace.
# See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
# RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
# RUN sudo apt-get install -y ubuntu-make

# Copy files:
# COPY toolkits/packages/@rtapp-non-thejuicemedia-refs/DO-NOT-MERGE.gildedguy-and-yoopia /home/coder/.local/more-corporate-clickbait-bullshit.headquarters.com.au
# TL;DR: Honest Government Ads reference ahead above

# Helper scripts and custom bashrc stuff so we can
# skip editing the main ~/.bashrc on our own
COPY toolkits/packages/scripts/ /home/coder/.local/bin/
COPY toolkits/packages/dotbashrcdir /home/coder/.bashrc_d
RUN (echo; echo "for i in \$(ls \$HOME/.bashrc.d/*); do source \$i; done"; echo) >> /home/coder/.bashrc

# Cloudflared
RUN IMAGE_ARCH=$(arch) $PWD/.local/bin/cloudflare-updater

# croc
RUN curl https://getcroc.schollz.com | sudo bash

# Homebrew on Linux
RUN /home/coder/.local/bin/linuxbrew-installer
# These should be fine for now.
ENV PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/" \
    MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man" \
    INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info" \
    HOMEBREW_NO_AUTO_UPDATE=1

# -----------

# Cleanup
RUN echo "[code-server] Dependency installation completed, cleaning up..." \
    && rm -rv /home/coder/*.deb || true \
    && sudo apt clean \
    && sudo rm -rvf /var/lib/apt/lists/* \
    && sudo rm -rvf /var/tmp/* \
    && echo "[code-server] Cleanup done"

# Since the entrypoint script is running the server in port 8080
# we just need to expose the main port instead of hardcoding the
# PORT variable.
EXPOSE 8080

# Use our custom entrypoint script first
COPY toolkits/containers/entrypoint.sh /usr/bin/cdr-server-launchpad
RUN echo "[code-server] Workspace image ready to deploy"

# Prepare volumes stuff
VOLUME [ "/workspace" ]
VOLUME [ "/home/linuxbrew/.linuxbrew" ]

# Then we can summon the Server Launchpad (aka toolkits/containers/entry.sh file on source code)
# Not to be confused with Launchpad.net
ENTRYPOINT ["/usr/bin/cdr-server-launchpad"]
