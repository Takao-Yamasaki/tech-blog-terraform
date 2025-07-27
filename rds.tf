# ------------------------------
# RDS subnet groups
# ------------------------------
resource "aws_db_subnet_group" "main" {
  name = "${local.project}-db"
  subnet_ids = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_c.id,
  ]
}

# ------------------------------
# RDS instance
# ------------------------------
resource "aws_db_instance" "main" {
  identifier = "${local.project}-db"
  engine = "mysql"
  engine_version = "8.0.41"
  instance_class = "db.t4g.micro"
  allocated_storage = 20
  
  db_name = "techblog"
  username = "techblog"
  manage_master_user_password = true

  # NOTE: パブリックアクセスを無効化
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [ aws_security_group.db.id ]
  
  # NOTE: 削除保護を無効化
  deletion_protection = false
  skip_final_snapshot = true

  # ログの有効化
  # TODO: DBへ接続して確認してみる
  # enabled_cloudwatch_logs_exports = [
  #   "error",
  #   "general",
  #   "slowquery",
  #   "audit"
  # ]
}
