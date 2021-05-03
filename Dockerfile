# Start from the code-server Debian base image
FROM codercom/code-server:3.9.3

USER root
RUN su coder chsh -s "$(which bash)"

USER coder

# Apply VS Code settings
COPY toolkits/containers/settings.json .local/share/code-server/User/settings.json

# Use bash shell, just in case.
ENV SHELL=/usr/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update \
    && sudo apt-get install unzip jq -y \
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

# Cloudflared
RUN wget -q https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && sudo dpkg -i cloudflared-stable-linux-amd64.deb

# croc
RUN curl https://getcroc.schollz.com | sudo bash
ENV PATH="/usr/local/bin:$PATH"

# -----------

# Cleanup
RUN rm -rv /home/coder/*.deb \
    && sudo apt clean

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY toolkits/containers/entrypoint.sh /usr/bin/cdr-server-launchpad
RUN sudo chmod +x /usr/bin/cdr-server-launchpad
ENTRYPOINT ["/usr/bin/cdr-server-launchpad"]
