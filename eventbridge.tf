
resource "aws_scheduler_schedule_group" "rds_auto_start_stop" {
  name = "rds_auto_start_stop"
}

# https://zenn.dev/n06u1886/articles/1282f91a732ca3#eventbrigdescheduler%E3%82%92terraform%E3%81%A7%E4%BD%9C%E6%88%90
resource "aws_scheduler_schedule" "rds_auto_stop" {
  name = "rds_auto_stop"
  group_name = aws_scheduler_schedule_group.rds_auto_start_stop.name
  schedule_expression_timezone = "Asia/Tokyo"
  schedule_expression = "cron(00 23 ? * * *)"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn = "arn:aws:scheduler:::aws-sdk:rds:stopDBInstance"
    role_arn = aws_iam_role.rds_auto_stop_role.arn
    input = jsonencode({
      "DbInstanceIdentifier": aws_db_instance.main.identifier
    })
  }
}
