

resource "aws_s3_bucket" "remote_store" {

  count = module.vars.env.create_remote ? 1 : 0

  bucket = var.bucket_name

  force_destroy = true

  tags = {
    Name      = var.bucket_name
    ManagedBy = "Terraform"
  }
}

resource "aws_dynamodb_table" "remote-lock" {

  count = module.vars.env.create_remote ? 1 : 0

  name           = var.dydb_name
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name      = "DynamoDB Terraform State Lock Table"
    ManagedBy = "Terraform"
  }
}
