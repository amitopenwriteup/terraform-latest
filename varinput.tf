provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-2"   # Replace with your desired AWS region
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}
output "available_zones" {
  value = data.aws_availability_zones.available.names
}

variable "selected_zone" {
  description = "Selected availability zone"
  type        = string
}

resource "aws_instance" "example" {
  ami           = "ami-0b8987a72eee28c3d"   # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = "subnet-0e09953db95a5ac65"     # Replace with your desired subnet ID
  key_name      = "my-key-pair"             # Replace with your desired key pair name
  availability_zone = var.selected_zone
  tags = {
    Name        = "instance1"
  }
}
