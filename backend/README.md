# README

- [README](#readme)
  - [Summary](#summary)
  - [Setup](#setup)
    - [Development container](#development-container)
    - [Environment variables](#environment-variables)
    - [Dependencies](#dependencies)
    - [Database migrations](#database-migrations)
    - [Deployment](#deployment)
    - [Remove](#remove)
  - [Contribution guidelines](#contribution-guidelines)
    - [Code review](#code-review)
    - [Other guidelines](#other-guidelines)
  - [Glossary](#glossary)
    - [Service environment variables: `.envs/config.env`](#service-environment-variables-envsconfigenv)
    - [Serverless Framework deployment variables](#serverless-framework-deployment-variables)

---

## Summary

`Test2 Backend` repository contains all necessary cloud resources to process and save history for alarms.
These resources are created using `Infrastructure as Code` approach and deployed using `Serverless Framework`.

---

## Setup

### Development container

This steps are tailored to work with Visual Studio Code, but you are free to chose a different IDE and make necessary adjustments to the setup.

1. Install `ms-vscode-remote.remote-containers` extension. If you don't know how to do that follow this steps: <https://code.visualstudio.com/docs/editor/extension-gallery#_install-an-extension>
2. Open this project's folder in Visual Studio Code. The extension will detect a container configuration and will ask you if you want to reopen the project un the container. Accept.

### Environment variables

At `.envs` folder, you'll need to create env files with the variables described [here](#glossary).

### Dependencies

`serverless` user must be created using `IAM` at `AWS Organization account`, and it's credentials configured in `.envs/aws.env`.

You need these `Cloud Formation Stacks` deployed:

- `Test2 > Infrastructure` stack

Those stacks deploy, among other resources, some parameters at `SSM Parameter Store`. You can also choose to manually configure those parameters instead of deploying the stacks. To learn more about the parameters you'll need to read the docs of the corresponding dependency.

### Database migrations

To apply pending database migrations, run `database/migrations/migrate.sh`.

To rollback database migrations, run `database/migrations/migrate.sh --rollback`.

To add a new migration step yo need to modify `database/migrations/Migration.js` file.

### Deployment

You can deploy `Cloud Formation Stacks` using `Serverless Framework` syntax: <https://www.serverless.com/framework/docs/providers/aws/cli-reference/deploy/>

Deployment order:

1. [Apply database migrations](#database-migrations)
2. Deploy `lambda-layers/mysql` stack
3. Deploy `serverless` stack

### Remove

You must use `Serverless Framework` remove command as primary option: <https://www.serverless.com/framework/docs/providers/aws/cli-reference/remove/>

If `remove` command fails for whatever reason, you'll need to investigate the reason using `AWS Console` at your browser, solve the issue and then re-attempt the `remove` command.

You can, alternatively, delete the `AWS Cloud Formation` stack manually using `AWS Console` at your browser. But it's recommended to do it using the `remove` command from Serverless Framework.

Stacks are independent, but still, recommended remove order is inverse to deployment order.

---

## Contribution guidelines

### Code review

- Use known standards where situation allows it.
- Use known solutions for known problems.

### Other guidelines

- Investigate known and proven solutions before manufacturing your own.
- Check if our cloud provider offers a service you could use to solve the problem: evaluate ease of use, costs, maturity and reviews.
- If you need to use a library make sure it's mature, has continuous releases, it's stable.
- If a solution starts to get too messy, it's probably not the right solution.

---

## Glossary

### Service environment variables: `.envs/config.env`

- `DEVELOPER`: Same username as you corporate email without domain part. It's used to guarantee some unique resource names at deploy

### Serverless Framework deployment variables

- `stage`: Means the deployment stage. Values can be `dev`
- Other deployment options can be set through CLI command. More info [here](https://www.serverless.com/framework/docs/providers/aws/cli-reference/deploy/)
