resource "aws_db_instance" "default" {
  count = var.enable_rds ? 1 : 0
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "mydb"
  username         = "admin"
  password         = "password123"
  skip_final_snapshot = true
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}
