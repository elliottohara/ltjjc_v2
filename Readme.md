# S3 Website Deployment
A simple project to deploy a static website to S3

Currently the src directory of this project is my Brazilian Jiu-Jitsu website, but it could be forked to create
any static website we wanted to host on S3.

Uses terraform for infrastructure, but does so in a docker container, so terraform need not be installed on host computer

To use: 
* Clone the repo
* Build your website in the src directory
* run `./build.sh dev` to get a dev server running locally (nginx docker image service files with another container
running gulp watch to compile your scss to css)
* Update terraform/terraform.tfvars to set your domain name (no need for the www)
* create a secrets.auto.tfvars file with your aws_access_key and aws_secret_key (this file is .gitignored) 
* run `./build.sh init` to setup terraform
* run `./build.sh deploy` to create your aws resources and deploy


## TODO Stuff
* Still need local SSL. FB js sdk requires it, so might as well set it up