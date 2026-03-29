# IAC scanner testing fixtures - Terraform with known misconfigurations

# CKV_AWS_18 - S3 bucket without access logging
# CKV_AWS_19 - S3 bucket without server-side encryption
# CKV_AWS_21 - S3 bucket without versioning
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"

  tags = {
    Name        = "insecure-bucket"
    Environment = "test"
  }
}

# CKV_AWS_46 - EC2 instance with public IP
# CKV_AWS_8 - Launch configuration with unencrypted EBS
resource "aws_instance" "insecure_instance" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Name = "insecure-instance"
  }
}

# CKV_AWS_23 - Security group with unrestricted ingress
resource "aws_security_group" "wide_open" {
  name        = "wide-open-sg"
  description = "Security group with unrestricted access"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# CKV_AWS_24 - Security group allows SSH from 0.0.0.0/0
resource "aws_security_group" "ssh_open" {
  name        = "ssh-open-sg"
  description = "Security group allowing SSH from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# CKV_AWS_157 - RDS without multi-AZ
# CKV_AWS_16 - RDS without encryption
resource "aws_db_instance" "insecure_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "password123"
  publicly_accessible  = true
  storage_encrypted    = false
  multi_az             = false
  skip_final_snapshot  = true
}

# CKV_AWS_145 - S3 bucket without KMS encryption
resource "aws_s3_bucket" "no_encryption" {
  bucket = "no-encryption-bucket"
}

# CKV_AWS_144 - S3 bucket without cross-region replication
resource "aws_s3_bucket" "no_replication" {
  bucket = "no-replication-bucket"
}
