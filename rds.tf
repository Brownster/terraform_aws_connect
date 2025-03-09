module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.0"

  identifier            = "my-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_encrypted    = true
  username            = local.db_creds["username"]
  password            = local.db_creds["password"]
  skip_final_snapshot = true
}
