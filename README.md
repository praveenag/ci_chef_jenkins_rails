# Chef Jenkins Rails

This repo contains recipes for provisioning a jenkins server set up to run CI on rails apps.

## Disclaimer and Alternatives

All code used in this repo was written by a bunch of smart people (not me)

TODO: lobot


## How to use

clone the repo to your local machine - `git clone TODO`

cd into the repo, create a gemset if desired, then:

```
# install knife-solo and chef-librarian
bundle install

# install the cookbooks defined in Cheffile (NOTE: these are ignored in .gitignore)
librarian-chef install
```



## What do you get?

* Jenkins server installed with the following plugins:
  * rvm
  * TODO: finish list
* nginx with ssl and basic authorization so your CI is protected
* postgresql - for running your rails tests
* nodejs - for compiling your rails assets 

















## Steps used to create this project
bundle install gems
knife solo init .
librarian-chef init


