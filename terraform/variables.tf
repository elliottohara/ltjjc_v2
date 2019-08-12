 variable "aws_region" {
  default = "us-east-1"
   description = "The AWS region to install resources in."
}
variable "aws_profile" {
  default = "default"
  description = "The aws profile (in ~/.aws/credentials) to use to create all AWS resources."
}
variable "website_subdomain" {
  default = "www"
  description = "The subdomain for your website."
}

variable "dns_name" {
  description = "The DNS name of your website. Should already have a AWS Route53 hosted zone set up for it."
  default = ""
}
 variable "use_acm" {
   description = "Use SSL or not? If set to true, make sure an AWS ACM cert already exists for the website domain"
   default = false
 }
 variable "cloud_front_price_class" {
   description = "The price class to use for the Cloudfront distribution"
   default = "PriceClass_100"
 }
 variable "default_root_document" {
  description = "Your default root document. "
   default = "index.html"
}
variable "aws_access_key" {
  description = "Your aws access key. Populate this in secrets.auto.tfvars since that file is gitignored"
}
variable "aws_secret_key" {
  description = "Your aws secret key. Populate this in secrets.auto.tfvars since that file is gitignored"
}