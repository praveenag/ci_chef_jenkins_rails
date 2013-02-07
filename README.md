# WIP: Chef Jenkins Rails

This repo contains recipes for provisioning a jenkins server set up to run CI for rails apps.

TODO: WIP

* force connections to go through nginx
* update all README content
* pre-load with sample config for a rails project

## Disclaimer and Alternatives

All code used in this repo was written by a bunch of smart people (not me). I hobbled together bits, mostly from the lobot project while trying to gain more knowledge about how chef and knife work.

TODO: lobot link


## How to use

clone the repo to your local machine - `git clone TODO`

cd into the repo, create a gemset if desired, then:

```
# install knife-solo and chef-librarian
bundle install

# install the cookbooks defined in Cheffile (NOTE: these are ignored in .gitignore)
librarian-chef install
```

update the passwords in nodes/main.json

prepare your server - TODO: digitalocean / vagrant

```
# replace user and host - i.e. root@192.168.0.0
knife solo prepare user@host --omnibus-version=10.18.2 --node-name=main
# install recipes, could take some time...
knife solo cook user@host nodes/main.json --skip-chef-check
```

## What do you get?

* Jenkins server installed with the following plugins:
  * rvm
  * TODO: finish list
* nginx with ssl and basic authorization so your CI is protected
* postgresql - for running your rails tests
* nodejs - for compiling your rails assets






## Notes...
bundle install gems
knife solo init .
librarian-chef init
knife solo prepare root@host --omnibus-version=10.18.2
knife solo cook root@host nodes/main.json --skip-chef-check

```
https://github.com/house9/ci_sample_app.git

bundle install
cp config/database.yml.jenkins config/database.yml
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec rake test
```

