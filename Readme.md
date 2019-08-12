# S3 Website Deployment
A simple project to deploy a static website to S3. Also includes nginx docker hosting of files with SSL and a gulp
watcher.

Currently the src directory of this project is my Brazilian Jiu-Jitsu website, but it could be forked to create
any static website we wanted to host on S3.

Uses terraform for infrastructure, and openssl to generate dev SSL certs for testing. Nothing needs to be installed 
locally except docker and docker-compose, since everything is done in docker containers.

To use: 
* Clone the repo
* Update the `AWS_PROFILE` variable on line 2 of `build.sh` to use a valid aws cli profile (probably can just be default
for most)
* Build your own website in the src directory
* run `make init` to generate dev ssl certs and initialize terraform.
* run `make local_dev` to get a dev server running locally (nginx docker image service files with another container
running gulp watch to compile your scss to css)
* Update `terraform/terraform.tfvars` to set your domain name (no need for the www)
* run `./build.sh deploy` to create your aws resources and deploy


## Terraform
The build script allows you to run arbitrary terraform commands like so. `./build.sh tf <command> <args>`.
For example `./build.sh show` would show all the resources that exist. 

## TODO Stuff
* Still need local SSL. FB js sdk requires it, so might as well set it up, since I wanna use FB graph stuff on the page.