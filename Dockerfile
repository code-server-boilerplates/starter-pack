# Start from the code-server Debian base image
FROM codercom/code-server:3.10.2

# Add image labels here, but read comments as you edit
# Replace code-server-boilerplates with username-here/repo
LABEL org.opencontainers.image.source="https://github.com/code-server-boilerplates/starter-pack" \
      org.opencontainers.image.vendor="code-server Community" \
      org.opencontainers.image.documentation="https://rtapp.tk/cdrs-boilerplates-docs"

# Update PATH to enusre both user-wide scripts and our stuff
# on /usr/local/bin are available to summon
ENV PATH="/usr/local/bin:/home/coder/.local/bin:$PATH" \
    # prefix for thr entrypoint logs, in which you should update into
    # @namespace/template-slug
    TEMPLATE_SLUG_PREFIX="@code-server-boilerplates/example-project"

USER root
# use Bash by default
RUN echo "[code-server] Image build starts on $(arch)" \
    && chsh -s /bin/bash coder && chsh -s /bin/bash

USER coder
# Apply VS Code settings
COPY toolkits/containers/settings.json .local/share/code-server/User/settings.json

# Use bash shell, just in case.
ENV SHELL=/bin/bash

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

# Helper scripts
COPY toolkits/packages/scripts/ /home/coder/.local/bin/

# Cloudflared
RUN IMAGE_ARCH=$(arch) $PWD/.local/bin/cloudflare-updater

# croc
RUN curl https://getcroc.schollz.com | sudo bash

# -----------

# Cleanup
RUN echo "[code-server] Dependency installation completed, cleaning up..." \
    && rm -rv /home/coder/*.deb || true \
    && sudo rm -rvf /var/lib/apt/lists/* \
    && sudo apt clean \
    && echo "[code-server] Cleanup done"

# Since the entrypoint script is running the server in port 8080
# we just need to expose the main port instead of hardcoding the
# PORT variable.
EXPOSE 8080

# Use our custom entrypoint script first
COPY toolkits/containers/entrypoint.sh /usr/bin/cdr-server-launchpad
RUN echo "[code-server] Workspace image ready to deploy"

VOLUME [ "/home/coder/project", "/workspace" ]
ENTRYPOINT ["/usr/bin/cdr-server-launchpad"]
