# StackStorm in Docker containers

[![Circle CI Build Status](https://circleci.com/gh/StackStorm/st2-docker/tree/master.svg?style=shield)](https://circleci.com/gh/StackStorm/st2-docker)
[![Go to Docker Hub](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/stackstorm/stackstorm/)


## READ FIRST!!

- **Check the [CHANGELOG.rst](https://github.com/StackStorm/st2-docker/blob/master/CHANGELOG.rst)**
  file for any potential changes that may require restarting containers.
- Be sure to use the latest `docker-compose.yml`. Run `git pull` in your `st2-docker` workspace!
- Run `st2ctl reload --register-all` to reload all services.
- **For information on how the stackstorm docker image is versioned, see
  [VERSIONING.md](https://github.com/StackStorm/st2-docker/blob/master/VERSIONING.md)**.
- If a specific image version is required, it is always best to be explicit and specify the image
  digest. See the example of setting `ST2_IMAGE_TAG` environment variable [below](#EnvVars).
- Kubernetes installation is available via Helm charts at https://docs.stackstorm.com/install/k8s_ha.html
  and provides High Availability deployment for both StackStorm Community and Enterprise editions.


## TL;DR

```
git clone https://github.com/gkzz/st2-docker-gkz.git 
cd st2-docker-gkz
make env
export HUBOT_SLACK_TOKEN=xoxb-your-token
docker-compose -f docker-compose-dev.yml up -d
docker-compose exec stackstorm bash
```