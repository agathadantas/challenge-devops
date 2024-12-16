output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_versioning_status" {
  description = "Versioning status of the S3 bucket"
  value       = aws_s3_bucket.bucket.versioning[0].status
}
