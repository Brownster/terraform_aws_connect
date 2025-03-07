resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidrs)
  vpc_id           = aws_vpc.main.id
  cidr_block       = var.subnet_cidrs[count.index]
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
