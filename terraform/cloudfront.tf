resource "aws_cloudfront_distribution" "cf" {
  enabled = false
  price_class = "${var.cloud_front_price_class}"
  "default_cache_behavior" {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET","HEAD"]
    target_origin_id = "${aws_s3_bucket.website.id}"
    viewer_protocol_policy = ""
    "forwarded_values" {
      query_string = false
      "cookies" {
        forward = "none"
      }
    }
  }
  "origin" {
    domain_name = "${aws_s3_bucket.website.website_endpoint}"
    origin_id = "${aws_s3_bucket.website.id}"
  }
  "restrictions" {
    "geo_restriction" {
      restriction_type = "none"
    }
  }
  "viewer_certificate" {
    acm_certificate_arn = "${data.aws_acm_certificate.cert.arn}"
  }
}