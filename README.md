[![tests](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml/badge.svg)](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

## What is ddev-mongo?

This repository provides Mongo and Mongo Express add-on to [DDEV](https://ddev.readthedocs.io).

It's based on [MongoDb from Docker Hub](https://hub.docker.com/_/mongo?tab=description#-via-docker-stack-deploy-or-docker-compose), [DDEV custom compose files](https://ddev.readthedocs.io/en/stable/users/extend/custom-compose-files/) and [API Platform tutorial](https://api-platform.com/docs/core/mongodb/#enabling-mongodb-support).

## Configuration

1. Your project will likely require the [Doctrine MongoDB ODM bundle](https://github.com/doctrine/DoctrineMongoDBBundle)
   `ddev composer require doctrine/mongodb-odm-bundle:^4.0.0@beta doctrine/mongodb-odm:^2.0.0@beta`

2. In your application `.env` or other client, set the connection string:

    ```
    MONGODB_URL=mongodb://db:db@mongo:27017
    MONGODB_DB=api
    ```

Mongo Express will now be accessible from `http://<project>.ddev.site:9091`

## Caveats:

* The php extension (phpX.X-mongodb) is set up in `.ddev/config.mongo.yaml` using `webimage_extra_packages`. If you have an earlier `webimage_extra_packages` in your config.yaml, this will override it. You may want to edit your config.yaml to do what you want and remove the config.mongo.yaml.
* You can't define custom MongoDB configuration with this current setup.
* You can't use `ddev import-db` to import to mongo.


**Based on the original [ddev-contrib recipe](https://github.com/ddev/ddev-contrib/tree/master/docker-compose-services/mongodb)**

**Originally contributed by [@wtfred](https://github.com/wtfred)**

**Maintained by [@julienloizelet](https://github.com/julienloizelet)**
