variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "The bucket name must follow AWS naming rules: lowercase letters, numbers, dots, and hyphens only."
  }
}
