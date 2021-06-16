
resource "aws_s3_bucket" "main_s3_bucket" {

  bucket = var.bucket
  acl    = var.acl

}

output "s3_bucket_id" {
  value = aws_s3_bucket.main_s3_bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main_s3_bucket.arn
}
