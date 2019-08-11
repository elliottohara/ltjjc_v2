
locals{
  cf_origin_id = "S3-${aws_s3_bucket.website.bucket}"
}
resource "aws_cloudfront_distribution" "cf" {
  count = "${var.use_acm ? 1: 0}"
  enabled = true
  is_ipv6_enabled = true
  price_class = "${var.cloud_front_price_class}"
  aliases = ["${local.website_bucket}", "${var.dns_name}"]
  default_root_object = "${var.default_root_document}"
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET","HEAD"]
    target_origin_id = "${local.cf_origin_id}"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  origin {
    domain_name = "${aws_s3_bucket.website.bucket_domain_name}"
    origin_id = "${local.cf_origin_id}"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = "${element(data.aws_acm_certificate.cert.*.arn,0)}"
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method = "sni-only"
  }
}