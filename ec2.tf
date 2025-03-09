module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0.0"

  name = "web-server"

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]

  user_data = file("${path.module}/userdata.sh")
}
