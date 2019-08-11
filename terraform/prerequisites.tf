
# We're assuming DNS Zone and ACM cert where manually created.

data "aws_route53_zone" "zone"{
  name = "${var.dns_name}"
}

data "aws_acm_certificate" "cert"{
  count = "${var.use_acm ? 1: 0}"
  domain = "${local.website_bucket}"
}