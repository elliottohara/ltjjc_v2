# S3 Website Deployment
A simple project to deploy a static website to S3. Also includes nginx docker hosting of files with SSL and a gulp
watcher.

Currently the src directory of this project is my Brazilian Jiu-Jitsu website, but it could be forked to create
any static website we wanted to host on S3.

Uses terraform for infrastructure, and openssl to generate dev SSL certs for testing. Nothing needs to be installed 
locally except docker and docker-compose, since everything is done in docker containers.

## To run locally: 
* Clone the repo
* run `make local_dev` to get a dev server running locally. This will generate dev certs,  set up a gulp watcher and 
start an nginx server hosting the contents of `src`. 
* visit https://0.0.0.0
* Make all the changes you want.

## To deploy
* You need to already have a AWS Route53 Hosted Zone set up for your domain.
* Modify terraform.tfvars to appropriate values for your domain. 
* If you have an ACM cert for the domain, and would like
to use SSL, set `use_acm` to `true` and it will set up a cloudfront distribution with SSL redirect.
* Create a secrets.auto.tfvars and set your `aws_access_key` and `awsaws_secret_key` with your credentials.
* run `make init` to generate dev ssl certs and initialize terraform.
* Update `terraform/terraform.tfvars` to set your domain name (no need for the www)
* run `./build.sh deploy` to create your aws resources and deploy


## Terraform
The build script allows you to run arbitrary terraform commands like so. `./build.sh tf <command> <args>`.
For example `./build.sh show` would show all the resources that exist. 
