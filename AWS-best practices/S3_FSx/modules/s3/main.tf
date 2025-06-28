resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  bucket        = "${var.bucket_prefix}-${random_id.suffix.hex}"
  force_destroy = true
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
