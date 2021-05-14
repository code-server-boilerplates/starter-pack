# Start from the code-server Debian base image
FROM codercom/code-server:3.10.0

USER root
# use Bash by default
RUN echo "[code-server] Image build starts on $(arch)" \
    && chsh -s /bin/bash coder && chsh -s /bin/bash \
    && mkdir /home/coder/.local/bin -p
# this should fix any errors on missing system-wide Bash completion directory
#RUN mkdir /etc/bash_completion.d

USER coder
# Apply VS Code settings
COPY toolkits/containers/settings.json .local/share/code-server/User/settings.json

# Use bash shell, just in case.
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
# Also don't forget wget for that. jq included too
RUN sudo apt-get update \
    && sudo apt-get install unzip jq wget tree -y \
    && sudo rm -rvf /var/lib/apt/lists/*
RUN curl https://rclone.org/install.sh | sudo bash

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
RUN ls /home/coder/.local && tree . -ah
RUN IMAGE_ARCH=$(arch) $PWD/.local/bin/cloudflare-updater || true

# croc
RUN curl https://getcroc.schollz.com | sudo bash
ENV PATH="/usr/local/bin:/home/coder/.local/bin:$PATH"

# -----------

# Cleanup
RUN echo "[code-server] Cleanup has been started" \
    && rm -rv /home/coder/*.deb || true \
    && sudo apt clean \
    && echo "[code-server] Cleanup done"

# Port, remember to use other env for this or do these:
#   PORT=3000 node server.js
ENV PORT=8080
EXPOSE 8080

# Use our custom entrypoint script first
COPY toolkits/containers/entrypoint.sh /usr/bin/cdr-server-launchpad
RUN echo "[code-server] Workspace image ready to deploy"
ENTRYPOINT ["/usr/bin/cdr-server-launchpad"]
