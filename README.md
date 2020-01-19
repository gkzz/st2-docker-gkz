# StackStorm in Docker containers

<img src="/docs/img/st2_deumo_junos.gif" alt="st2_deumo_junos" style="max-width:5%;">

## READ FIRST!!

- Be sure to use the latest `docker-compose-dev.yml`. Run `git pull` in your `st2-docker-gkz` workspace!
- Run `st2ctl reload --register-all` to reload all services.
- The packs I make a use of are as bellow:
  - [Ansible](https://github.com/StackStorm-Exchange/stackstorm-ansible)
  - [Slack](https://github.com/StackStorm-Exchange/stackstorm-slack)
  - [mydemo_pack](https://github.com/gkzz/mydemo_pack)


## TL;DR

- Set Your Environment Variables
```
$ tail ~/.bashrc
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

## Technologies Used

<img src="/docs/img/st2_docker_ansible.png" alt="technologies_used" style="max-width:5%;">

- AWS (EC2, VPC, EIP, etc)
    - Ubuntu 18.04.3 LTS
    - t2.large
    - Public Subnet Only
    - Auto-assign Public IP Enable
    - General Purpose SSD (gp2)、8size 
    - Security Group
        - ssh: accepted from local
        - HTTP/HTTPS: Fully Open
            - HTTP for App Container
            - HTTPS for Web Portal of Stackstormweb

- Stackstorm
    - Stackstorm: 3.1.0, on Python 2.7.6 
        - Stackstorm version 3.0 + is requiered in order to make a use of `orquesta`
    - RabbitMQ: 3.6
    - MongoDB: 3.4
    - Redis: 4.0
    - Postgresql: 9.6
    - Docker version 19.03.5, build 633a0ea838
    - docker-compose version 1.24.1, build 4667896b


## Usage

- Execute `. st2-docker/opt/reload.sh` on `Docker Container`
```
root@$HOSTNAME:/# . st2-docker/opt/reload.sh
````

- Run `playbook-demo-junos`
```
root@$HOSTNAME:/# st2 run playbook-demo-junos
```

- Run `poll-repo-python`
```
root@$HOSTNAME:/# st2 run poll-repo-python
```


## Notes

```
root@$HOSTNAME:/# tree /st2-docker/opt/
/st2-docker/opt/
├── reload.d
│   ├── add-ansible-pack.sh             # Add ansible pack
│   ├── add-slack-pack.sh               # Add slack pack
│   ├── clone_repo.sh                   # Git clone the repo of your app, if it does NOT exist
│   └── create-pack-mydemo.sh           # Add mydemo pack
├── reload.sh                           # Shellscript to run `/st2-docker/opt/reload.d/*.sh` one by one
└── requirements.txt.dev                # python libraries like mock

1 directory, 6 files
```