# S3 Website Deployment
A simple project to deploy a static website to S3

Currently the src directory of this project is my Brazilian Jiu-Jitsu website, but it could be forked to create
any static website we wanted to host on S3.

To use: 
* Clone the repo
* Build your website in the src directory
* run `./build.sh dev` to get a dev server running locally (nginx docker image service files with another container
running gulp watch to compile your scss to css)
* Update terraform/terraform.tfvars to set your domain name (no need for the www)
* run `./build.sh init` to setup terraform
* run `./build.sh deploy` to create your aws resources and deploy


