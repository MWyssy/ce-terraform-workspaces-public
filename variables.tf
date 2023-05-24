
variable "bucket_name" {
  description = "The name of the s3 bucket."
  type        = string
  default     = "ce-tf-remote-store"
}

variable "dydb_name" {
  description = "The name of the dynamoDb database."
  type        = string
  default     = "remote-lock"
}


