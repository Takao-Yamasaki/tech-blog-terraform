# ------------------------------
# security group for alb
# ------------------------------
resource "aws_security_group" "alb" {
  name = "${local.project}-alb"
  vpc_id = aws_vpc.main.id
  
  tags = {
    "Name" = "${local.project}-alb"
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------
# security group for api
# ------------------------------
resource "aws_security_group" "api" {
  name = "${local.project}-api"
  vpc_id = aws_vpc.main.id
  
  tags = {
    "Name" = "${local.project}-api"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------
# security group for db
# ------------------------------
resource "aws_security_group" "db" {
  name = "${local.project}-db"
  vpc_id = aws_vpc.main.id
  
  tags = {
    "Name" = "${local.project}-db"
  }

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [
      aws_security_group.api.id,
      aws_security_group.bastion.id
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------
# security group for bastion
# ------------------------------
resource "aws_security_group" "bastion" {
  name = "${local.project}-bastion"
  vpc_id = aws_vpc.main.id
  
  tags = {
    "Name" = "${local.project}-bastion"
  }

  # FIXME: ポートを閉じる
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      # NOTE: IP制限
      "49.109.0.0/16"
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
