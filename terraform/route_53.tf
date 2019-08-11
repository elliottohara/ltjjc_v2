

resource "aws_route53_record" "www" {
  name = "${local.website_bucket}"
  type = "A"
  zone_id = "${data.aws_route53_zone.zone.id}"
  alias {
    evaluate_target_health = false
    name = "${var.use_acm ? element(aws_cloudfront_distribution.cf.*.domain_name, 0) :aws_s3_bucket.website.website_endpoint}"
    zone_id = "${var.use_acm ? element(aws_cloudfront_distribution.cf.*.hosted_zone_id, 0):aws_s3_bucket.website.hosted_zone_id}"
  }
}

resource "aws_route53_record" "root_web" {
  name = "${var.dns_name}"
  type = "A"
  zone_id = "${data.aws_route53_zone.zone.id}"
  alias {
    evaluate_target_health = false
    name = "${var.use_acm ? element(aws_cloudfront_distribution.cf.*.domain_name, 0) : aws_s3_bucket.root.website_endpoint}"
    zone_id = "${var.use_acm ? element(aws_cloudfront_distribution.cf.*.hosted_zone_id, 0) : aws_s3_bucket.root.hosted_zone_id}"
  }
}
