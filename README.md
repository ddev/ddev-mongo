[![add-on registry](https://img.shields.io/badge/DDEV-Add--on_Registry-blue)](https://addons.ddev.com)
[![tests](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml?query=branch%3Amain)
[![last commit](https://img.shields.io/github/last-commit/ddev/ddev-mongo)](https://github.com/ddev/ddev-mongo/commits)
[![release](https://img.shields.io/github/v/release/ddev/ddev-mongo)](https://github.com/ddev/ddev-mongo/releases/latest)

# DDEV Mongo

## Overview

[MongoDB](https://www.mongodb.com/) is a source-available, cross-platform, document-oriented database program. Classified as a NoSQL database product, MongoDB uses JSON-like documents with optional schemas.

This add-on integrates MongoDB and Mongo Express into your [DDEV](https://ddev.com/) project.

It's based on [MongoDB from Docker Hub](https://hub.docker.com/_/mongo?tab=description), [DDEV custom compose files](https://docs.ddev.com/en/stable/users/extend/custom-compose-files/) and [API Platform tutorial](https://api-platform.com/docs/core/mongodb/#enabling-mongodb-support).

## Installation

```bash
ddev add-on get ddev/ddev-mongo
ddev restart
```

After installation, make sure to commit the `.ddev` directory to version control.

## Connection

By default, the database with the name `db` is created. You can connect to it using this connection string:

```text
mongodb://db:db@mongo:27017/db?authSource=admin
```

You can change the default database name, username, and password using env variables:

```bash
ddev dotenv set .ddev/.env.mongo \
    --mongo-initdb-root-username=db \
    --mongo-initdb-root-password=db \
    --mongo-initdb-database=db
```

If you want to disable authentication:

```bash
ddev dotenv set .ddev/.env.mongo \
    --mongo-initdb-root-username="" \
    --mongo-initdb-root-password="" \
    --me-config-mongodb-url=mongodb://mongo:27017
```

## Configuration

1. Your project will likely require the [Doctrine MongoDB ODM bundle](https://github.com/doctrine/DoctrineMongoDBBundle)

    ```bash
    ddev composer require doctrine/mongodb-odm-bundle doctrine/mongodb-odm
    ```

2. In your application `.env` or other client, set the connection string:

    ```dotenv
    MONGODB_URL=mongodb://db:db@mongo:27017
    ```

Mongo Express can now be started on demand using the `ddev mongo-express` command.

## Usage

| Command | Description |
| ------- | ----------- |
| `ddev mongosh` | Run MongoDB Shell, see the [documentation](https://www.mongodb.com/docs/mongodb-shell/) |
| `ddev mongo-express` | Start web-based MongoDB admin interface |
| `ddev describe` | View service status and used ports for MongoDB |
| `ddev logs -s mongo` | Check MongoDB logs |
| `ddev logs -s mongo-express` | Check Mongo Express logs (if it's started) |

## Caveats:

- You can't define custom MongoDB configuration with this current setup.
- You can't use `ddev import-db` to import to mongo.

## Advanced Customization

To change the Docker image:

```bash
ddev dotenv set .ddev/.env.mongo --mongo-docker-image=mongo:latest
ddev add-on get ddev/ddev-mongo
ddev restart
```

Make sure to commit the `.ddev/.env.mongo` file to version control.

All customization options (use with caution):

| Variable                     | Flag                           | Default                       |
|------------------------------|--------------------------------|-------------------------------|
| `MONGO_DOCKER_IMAGE`         | `--mongo-docker-image`         | `mongo:latest`                |
| `MONGO_EXPRESS_DOCKER_IMAGE` | `--mongo-express-docker-image` | `mongo-express:1.0`           |
| `MONGO_INITDB_ROOT_USERNAME` | `--mongo-initdb-root-username` | `db`                          |
| `MONGO_INITDB_ROOT_PASSWORD` | `--mongo-initdb-root-password` | `db`                          |
| `MONGO_INITDB_DATABASE`      | `--mongo-initdb-database`      | `db`                          |
| `ME_CONFIG_MONGODB_URL`      | `--me-config-mongodb-url`      | `mongodb://db:db@mongo:27017` |

## Credits

**Originally contributed by [@wtfred](https://github.com/wtfred)**

**Maintained by [@julienloizelet](https://github.com/julienloizelet)**
