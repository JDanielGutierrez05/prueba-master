# README

- [README](#readme)
  - [Summary](#summary)
  - [Setup](#setup)
    - [Dependencies](#dependencies)
    - [Development container](#development-container)
    - [Environment variables](#environment-variables)
  - [Glossary](#glossary)
    - [AWS environment variables: `.envs/aws.env`](#aws-environment-variables-envsawsenv)
    - [Serverless Framework environment variables: `.envs/sls.env`](#serverless-framework-environment-variables-envsslsenv)
    - [Project Distribution](#project-distribution)

---

## Summary

`Test2 Master` repository contains all necessary cloud resources to deploy infrastructure for service to run.
These resources are created as `Infrastructure as Code` and deployed using `Serverless Framework`.

---

## Setup

### Dependencies

`serverless` user must be created using `IAM` at `AWS Organization account`, and it's credentials configured in `.envs/aws.env`.

Need to create an acoount in `https://www.serverless.com` and generate access key to fill sls.env

### Development container

This steps are tailored to work with Visual Studio Code, but you are free to chose a different IDE and make necessary adjustments to the setup.

1. Install Visual Studio Code [here](https://code.visualstudio.com/)
2. Install Docker desktop [here](https://code.visualstudio.com/)
3. Install `ms-vscode-remote.remote-containers` extension. If you don't know how to do that follow this steps: <https://code.visualstudio.com/docs/editor/extension-gallery#_install-an-extension>
4. Open this project's folder in Visual Studio Code. The extension will detect a container configuration and will ask you if you want to reopen the project un the container. Accept. (Those steps are mandatory this time.)

### Environment variables

At `.envs` folder, you'll need to create env files with the variables decribed [here](#glossary).

---

## Glossary

### AWS environment variables: `.envs/aws.env`

- `AWS_ACCESS_KEY_ID`: _Access Key_ used to deploy Cloud Formation stack to AWS cloud. The owner of the _Access Key_ need to have sufficient IAM permissions to perform the deployment process.
- `AWS_SECRET_ACCESS_KEY`: _Secret Access Key_ that matches the _Access Key_
- `AWS_DEFAULT_REGION`: Region where you intend to deploy the stack
- `AWS_DEFAULT_OUTPUT`: Default response format for AWS CLI commands

Example:

```env
AWS_ACCESS_KEY_ID=abcd00000000adsasd
AWS_SECRET_ACCESS_KEY=abcd00000000adsasd
AWS_DEFAULT_REGION=us-east-1
AWS_DEFAULT_OUTPUT=json
```

### Serverless Framework environment variables: `.envs/sls.env`

- `SERVERLESS_ACCESS_KEY`: Serverless _Secret API Key_. Needed to deploy stack information to Serverless cloud and perform integration tests.

Example:

```env
SERVERLESS_ACCESS_KEY=abcd00000000adsasd
```

### Project Distribution

1. the first part cover Sections 1 and 3 of the PDF (All lambdas including others services deployments but needs some manual steps like create aws account, create serverless user, assign programatic keys and create serverless account and generate access key), you can follow the steps in ther respective readme.

- [Infrastructure](infrastructure/README.md)
- [Backend](backend/README.md)

1. the second part cover Section 2 of the PDF, its only a folder called database in the root of the repository with 3 sql files, one of them is the query, the other two are the files with the data that i used to test the script.
