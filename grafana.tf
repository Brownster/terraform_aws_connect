resource "aws_instance" "grafana" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 LTS
  instance_type = "t3.medium"
  security_groups = [aws_security_group.grafana_sg.id]

  tags = {
    Name = "GrafanaServer"
  }
}
