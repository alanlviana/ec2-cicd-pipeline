## EC2 CI/CD Pipeline Example

![Pipeline GitFlow](docs/pipeline.drawio.png)

This repository provides an automated way to provising EC2 to serve a python application using Github actions and terraform.

# Features
- **AWS Authentication**: Uses OpenID Connect (OICD) for secure AWS Access.
- **Infraestructure as code**: Deploy AWS resources using Terraform.
- **Automated cleanup**: Supports automatic resource destruction via a configuration file.
- **Multi-Environment Deployment**: Uses git branches to manage different environments.
- **Branch-based releases**: Each release is created from a specific branch, allowing for organized and controlled deployment.

## Prerequisites
- AWS Account with IAM permissions for OICD Authentication.