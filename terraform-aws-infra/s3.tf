resource "aws_s3_bucket" "helm_chart_bucket" {
  bucket = "fullstack-helm-chart-bucket"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Helm Chart Bucket"
  }
}

resource "aws_s3_bucket" "velero_backups" {
  bucket = "fullstack-mern-velero-backups"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Velero Backup Bucket"
  }
}
