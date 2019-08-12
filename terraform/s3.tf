locals {
  website_bucket = "${var.website_subdomain}.${var.dns_name}"
}
resource "aws_s3_bucket" "website" {
  bucket = "${local.website_bucket}"
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${local.website_bucket}/*"
      ]
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

}
# Do we even need this if we're using Cloudfront?
resource "aws_s3_bucket" "root" {
  bucket = "${var.dns_name}"
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.dns_name}/*"
      ]
    }
  ]
}
EOF

  website {
    redirect_all_requests_to = "${aws_s3_bucket.website.bucket}"
  }

}
