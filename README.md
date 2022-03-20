# sourcico

Dockerize folder is for docker compose, and not used in terraform deploy.
Helm folder, contains the help chart
Docker, containes work files for building the images into ECR.

For the terraform code to work, following tools need to be installed:
- kubectl
- awscli (and configured with account that has enough permissions)
- aws-iam-authenticator
- docker

The external URL to access the needed URL will be available after deploying the terraform code in the current work directory (from where the terraform is executed) with the name:
- **Access_url.out**
