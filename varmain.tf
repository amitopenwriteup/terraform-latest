resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id   # Replace with your desired AMI ID
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example_subnet.id     # Replace with your desired subnet ID
  key_name      = aws_key_pair.example.key_name          # Replace with your desired key pair name

  tags = {
    "Name" = format("MyInstance-%s", formatdate("YYYYMMDD", timestamp()))
  }
}
