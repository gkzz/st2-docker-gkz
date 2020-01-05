# StackStorm in Docker containers


## READ FIRST!!

- Be sure to use the latest `docker-compose-dev.yml`. Run `git pull` in your `st2-docker-gkz` workspace!
- Run `st2ctl reload --register-all` to reload all services.
- The packs I make a use of are as bellow:
  - [Ansible](https://github.com/StackStorm-Exchange/stackstorm-ansible)
  - [Slack](https://github.com/StackStorm-Exchange/stackstorm-slack)
  - [mydemo_pack](https://github.com/gkzz/mydemo_pack)


## TL;DR

- Set Your Environment Variables


tail ~/.bashrc
```
# Don't forget to execute `source ~/.bashrc` 
#   before building your container

export SLACKBOT_NAME='st2-bot'
export SLACKBOT_TOKEN='xoxb-xxxxxx'
export INCOMING_WEBHOOK_URL='https://hooks.slack.com/services/xxxyyy/zzz'
export DST_CHANNEL='dev'
export JUNOS_USER='hoge'
export JUNOS_PASS='password'
export JUNOS_PORT='xx'            
export JUNOS_IP='xxx.xxx.xxx.xxx'               
export GITHUB_ACCT='$NAME'           # https://qiita.com/$NAME
export GITHUB_SECRET_TOKEN='xxxxxxxxxxxxxxxxxxxxxxx'
export SERVICE_DIR='flask-docker'

```

- Build Your Container on `Docker Host`

```
$ git clone git@github.com/gkzz/st2-docker-gkz.git 
$ cd st2-docker-gkz
$ make env
$ git checkout tutorial-install-pack
$ docker-compose -f docker-compose-dev.yml up -d --build
$ docker-compose exec stackstorm bash
```

- Execute `. st2-docker/opt/reload.sh` on `Docker Container`
```
. st2-docker/opt/reload.sh
````