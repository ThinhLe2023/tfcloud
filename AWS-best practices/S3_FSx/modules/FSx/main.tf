resource "aws_security_group" "fsx_sg" {
  name   = "fsx-windows-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = [var.security_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_fsx_windows_file_system" "this" {
  subnet_ids            = [var.subnet_id]
  security_group_ids    = [aws_security_group.fsx_sg.id]
  storage_capacity      = 32
  throughput_capacity   = 8
  deployment_type       = "SINGLE_AZ_1"
  preferred_subnet_id   = var.subnet_id
  automatic_backup_retention_days = 0
  tags = {
    Name = "fsx-windows"
  }
}

output "fsx_dns_name" {
  value = aws_fsx_windows_file_system.this.dns_name
}
