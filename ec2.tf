resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 (Change as needed)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet[0].id
  security_groups = [aws_security_group.allow_ssh.name, aws_security_group.allow_http.name]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "WebServer"
  }
}
