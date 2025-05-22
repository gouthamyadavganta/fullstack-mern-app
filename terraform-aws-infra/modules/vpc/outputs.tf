output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "jump_ec2_public_ip" {
  description = "Public IP of the jump EC2 instance"
  value       = aws_instance.jump_ec2.public_ip
}
