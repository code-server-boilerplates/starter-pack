# Deploying `code-server` as an container with Heroku

1. Open this link: <https://cdrs-deploy.repohubdev.tk/heroku/example-project>
2. Fill the variables `GIT_REPO` and `PASSWORD` (preferrly using an generated password with
`openssl rand -hex 32` and paste the resulting key from the terminal).
3. Hit deploy and wait for the image build to succeed.
4. Open your project's publicly-accessible URL and hit the road.
   * When prompted for the password, copy the contents `PASSWORD` from the web UI.

## Supported environment variables

Please see [this documentation](/toolkits/containers/README.md) for full list of supported environment variables.
