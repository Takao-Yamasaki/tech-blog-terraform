# ------------------------------
# Key Pair(bastion)
# ------------------------------
resource "aws_key_pair" "bastion" {
  key_name = "${local.project}-bastion-keypair"
  public_key = file("./tech-blog-bastion-keypair.pub")
}

# ------------------------------
# EC2(bastion)
# ------------------------------
resource "aws_instance" "bastion" {
  # Amazon Linux 2023 (kernel-6.1) 
  ami = "ami-095af7cb7ddb447ef"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet_a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]
  key_name = aws_key_pair.bastion.key_name

  tags = {
    Name = "${local.project}-bastion"
  }
}
