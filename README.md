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

## Configuration

1. Your project will likely require the [Doctrine MongoDB ODM bundle](https://github.com/doctrine/DoctrineMongoDBBundle)

   ```bash
   ddev composer require doctrine/mongodb-odm-bundle doctrine/mongodb-odm
   ```

2. In your application `.env` or other client, set the connection string:

   ```dotenv
   MONGODB_URL=mongodb://db:db@mongo:27017
   ```

Mongo Express can now be started on demand using the `ddev mongo-express` command. (This optional feature is available starting from DDEV v1.24.4+.)

## Usage

| Command | Description |
| ------- | ----------- |
| `ddev mongosh` | Run MongoDB Shell, see the [documentation](https://www.mongodb.com/docs/mongodb-shell/) |
| `ddev mongo-express` | Start web-based MongoDB admin interface |
| `ddev describe` | View service status and used ports for MongoDB |
| `ddev logs -s mongo` | Check MongoDB logs |
| `ddev logs -s mongo-express` | Check Mongo Express logs (if it's started) |

## Caveats:

- The php extension (`phpX.X-mongodb`) is set up in `.ddev/config.mongo.yaml` using `webimage_extra_packages`. You may want to edit your `.ddev/config.yaml` to do what you want and remove the `.ddev/config.mongo.yaml`.
- You can't define custom MongoDB configuration with this current setup.
- You can't use `ddev import-db` to import to mongo.

## Advanced Customization

If you don't want to authenticate with the default admin user, create a new file `.ddev/docker-compose.mongo_extra.yaml`:

```yaml
services:
  mongo:
    environment:
      - MONGO_INITDB_ROOT_USERNAME=
      - MONGO_INITDB_ROOT_PASSWORD=
  mongo-express:
    environment:
      - ME_CONFIG_MONGODB_URL=mongodb://mongo:27017
```

(Don't forget to update your application's `.env` file.)

To change the Docker image:

```bash
ddev dotenv set .ddev/.env.mongo --mongo-docker-image=mongo:5-focal
ddev add-on get ddev/ddev-mongo
ddev restart
```

Make sure to commit the `.ddev/.env.mongo` file to version control.

All customization options (use with caution):

| Variable | Flag | Default |
| -------- | ---- | ------- |
| `MONGO_DOCKER_IMAGE` | `--mongo-docker-image` | `mongo:5-focal` |
| `MONGO_EXPRESS_DOCKER_IMAGE` | `--mongo-express-docker-image` | `mongo-express:1.0` |

## Credits

**Originally contributed by [@wtfred](https://github.com/wtfred)**

**Maintained by [@julienloizelet](https://github.com/julienloizelet)**
