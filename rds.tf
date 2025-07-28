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

  # パブリックアクセスを無効化
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [ aws_security_group.db.id ]
  
  # 削除保護を無効化
  deletion_protection = false
  skip_final_snapshot = true

  # 即時反映を有効化
  apply_immediately = true

  # ログの有効化
  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
    "slowquery",
    "audit"
  ]

  # DBパラメータグループ
  parameter_group_name = aws_db_parameter_group.main.name
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group
# https://qiita.com/m-oka-system/items/a45867495f95461b0a2c
resource "aws_db_parameter_group" "main" {
  name = "${local.project}-db-parameter-group"
  family = "mysql8.0"

  # 一般ログ
  parameter {
    name = "general_log"
    value = "1"
    apply_method = "immediate"
  }

  # スロークエリ
  parameter {
    name = "slow_query_log"
    value = "1"
    apply_method = "immediate"
  }

  # スロークエリの閾値
  parameter {
    name = "long_query_time"
    value = "1"
    apply_method = "immediate"
  }
}
