 variable "aws_region" {
  default = ""
}
variable "aws_profile" {
  default = ""
}
variable "aws_access_key" {
  default = ""
}
variable "website_subdomain" {
  default = "www"
}
variable "aws_secret_key" {
  default = ""
}

variable "dns_name" {
  default = ""
}
 variable "use_acm" {
   default = false
 }
 variable "cloud_front_price_class" {
   default = "PriceClass_100"
 }