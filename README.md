[![tests](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml/badge.svg)](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

## What is ddev-mongo?

This repository is an add-on that provides Mongo and Mongo Express for [DDEV](https://ddev.readthedocs.io/en/stable/).

It's based on [MongoDb from Docker Hub](https://hub.docker.com/_/mongo?tab=description#-via-docker-stack-deploy-or-docker-compose), [DDEV custom compose files](https://ddev.readthedocs.io/en/stable/users/extend/custom-compose-files/) and [API Platform tutorial](https://api-platform.com/docs/core/mongodb/#enabling-mongodb-support).

## Installation

For DDEV v1.23.5 or above run

```bash
ddev add-on get ddev/ddev-mongo
```

For earlier versions of DDEV run

```bash
ddev get ddev/ddev-mongo
```

Then restart your project

```bash
ddev restart
```

## Configuration

1. Your project will likely require the [Doctrine MongoDB ODM bundle](https://github.com/doctrine/DoctrineMongoDBBundle)
   `ddev composer require doctrine/mongodb-odm-bundle:^4.0.0@beta doctrine/mongodb-odm:^2.0.0@beta`

2. In your application `.env` or other client, set the connection string:

   ```
   MONGODB_URL=mongodb://db:db@mongo:27017
   ```

Mongo Express will now be accessible by running `ddev mongo-express` command.

## Features

### `ddev mongosh` command

This command will run the `mongosh` (mongoDB Shell) command in the `mongo` container. Please [read the documentation](https://www.mongodb.com/docs/mongodb-shell/) for more information.

### `ddev mongo-express` command

This command opens your browser to the Mongo Express page.

## Caveats:

- The php extension (phpX.X-mongodb) is set up in `.ddev/config.mongo.yaml` using `webimage_extra_packages`. You may want to edit your config.yaml to do what you want and remove the config.mongo.yaml.
- You can't define custom MongoDB configuration with this current setup.
- You can't use `ddev import-db` to import to mongo.

**Based on the original [ddev-contrib recipe](https://github.com/ddev/ddev-contrib/tree/master/docker-compose-services/mongodb)**

**Originally contributed by [@wtfred](https://github.com/wtfred)**

**Maintained by [@julienloizelet](https://github.com/julienloizelet)**
