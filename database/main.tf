resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.project_name}-aurora-cluster"
  engine                  = "aurora-postgresql"

  database_name           = var.db_name
  master_username         = var.db_master_username
  master_password         = var.db_master_password


  backup_retention_period = 1
  preferred_backup_window = "03:00-04:00"
  skip_final_snapshot     = true

  db_subnet_group_name = aws_db_subnet_group.aurora.name

  vpc_security_group_ids = var.sg_ids

  serverlessv2_scaling_configuration {
    max_capacity             = 1.0
    min_capacity             = 0.0
    seconds_until_auto_pause = 3600
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-aurora-cluster"
  }
}

resource "aws_db_subnet_group" "aurora" {
  name       = "${var.project_name}-aurora-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-aurora-subnet-group"
  }
}

resource "aws_rds_cluster_instance" "aurora_writer" {
  identifier           = "${var.project_name}-aurora-writer-1"
  cluster_identifier   = aws_rds_cluster.aurora.id
  instance_class       = "db.serverless"

  engine               = aws_rds_cluster.aurora.engine
  engine_version       = aws_rds_cluster.aurora.engine_version

  publicly_accessible  = false

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-aurora-writer-1"
  }
}
