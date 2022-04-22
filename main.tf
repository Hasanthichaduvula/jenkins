provider "aws" {
    region = var.aws_region
}
resource "aws_s3_bucket" "b" {
  bucket = "tf-nk-state"

  tags = {
    Name        = var.bucket_name

  }
}
resource "aws_s3_bucket" "tf-nk-state" {
  bucket = aws_s3_bucket.b.id
}

resource "aws_dynamodb_table" "dynamodblocktable" {
  name           = var.dynamodb_name
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "TestTableHashKey"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }

resource "aws_instance" "ec-2" {
  ami           = var.ec2_ami
  instance_type = var.instance_type
  key_name = var.ec2_keypair
  count = var.ec2_count
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
  subnet_id = element(var.subnets, count.index)

  tags = {
    Name = "${var.environment}.${var.product}-${count.index+1}"
  }
}

