provider "aws" {
  region                   = "us-west-1"
  shared_config_files      = ["/root/.aws/config"]
  shared_credentials_files = ["/root/.aws/credentials"]
  profile                  = "default"
}
resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key file
}
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true  # Set this to true if you want instances in this subnet to receive public IP addresses

  tags = {
    Name = "example-subnet"
  }
}
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id   # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet.id     # Replace with your desired subnet ID
  key_name      = aws_key_pair.example.key_name          # Replace with your desired key pair name

  tags = {
    "Name" = format("MyInstance-%s", formatdate("YYYYMMDD", timestamp()))
  }
}
         