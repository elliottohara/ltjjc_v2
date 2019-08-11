
# We're assuming it was manually created when the domain was bought
data "aws_route53_zone" "zone"{
  name = "${var.dns_name}"
}


resource "aws_route53_record" "www_cname" {
  name = "${local.website_bucket}"
  type = "A"
  zone_id = "${data.aws_route53_zone.zone.id}"
  alias {
    evaluate_target_health = false
    name = "${aws_s3_bucket.website.website_endpoint}"
    zone_id = "${aws_s3_bucket.website.hosted_zone_id}"
  }
}
